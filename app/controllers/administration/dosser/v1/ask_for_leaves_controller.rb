class Administration::Dosser::V1::AskForLeavesController < Administration::Dosser::V1::PresentationController

  def create
    ActiveRecord::Base.transaction do
      leave_ids = []

      user = User.where(id: params[:user_id]).first
      render_conflict message: 'user_id参数不正确' and return if user.blank?
      render_conflict message: '用户已失效' and return if user.defunct

      params[:leave_info].each do |leave_info|

        render_conflict message: 'am_pm_code参数不正确' and return if ShareEnum.am_pms[leave_info[:am_pm_code].to_sym].blank?

        leave_day = nil
        begin
          leave_day = Time.parse leave_info[:leave_day]
        rescue
          render_conflict message: 'leave_day格式不正确' and return
        end

        start_time = leave_day.beginning_of_day
        end_time   = leave_day.end_of_day
        if params[:am_pm_code]=='am'
          start_time = Time.parse(params[:leave_day].strip+' 09:00:00')
          end_time   = Time.parse(params[:leave_day].strip+' 12:00:00')
        elsif params[:am_pm_code]=='pm'
          start_time = Time.parse(params[:leave_day].strip+' 1:00:00')
          end_time   = Time.parse(params[:leave_day].strip+' 18:00:00')
        elsif params[:am_pm_code]=='am_and_pm'
          start_time = Time.parse(params[:leave_day].strip+' 09:00:00')
          end_time   = Time.parse(params[:leave_day].strip+' 18:00:00')
        end

        ask_for_leave = AskForLeave.new user_id: params[:user_id].to_i,
                                        am_pm_code: leave_info[:am_pm_code],
                                        day: leave_day,
                                        opened_at: start_time,
                                        closed_at: end_time
        if ask_for_leave.save
          leave_ids.push(ask_for_leave.id)
        else
          render_conflict message: error_message(ask_for_leave) and return
        end
      end
      render_ok collection: [{leave_ids: leave_ids}] and return
    end
  end

  def destroy
    ActiveRecord::Base.transaction do
      render_conflict message: 'id参数不正确' and return if params[:id].blank?
      ask_for_leave = AskForLeave.find(params[:id])
      if ask_for_leave.soft_destroy
        render_ok and return
      else
        render_conflict message: error_message(ask_for_leave) and return
      end
    end
  end

end
