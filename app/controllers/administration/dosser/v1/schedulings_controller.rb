class Administration::Dosser::V1::SchedulingsController < Administration::Dosser::V1::PresentationController

  def create
    ActiveRecord::Base.transaction do
      office_time = OfficeTime.find(params[:office_time_id])
      render_conflict message: 'office_time_id参数不正确' and return if office_time.blank?
      render_conflict message: 'week参数不正确' and return if ShareEnum.weeks[params[:week].to_sym].blank?

      schedulings = Scheduling.office_time_id_is(params[:office_time_id]).week_code_is(params[:week])
      schedulings.delete_all

      collection = []
      params[:users].each do |user_info|
        render_conflict message: 'user_id参数错误' and return if user_info[:user_id].blank?
        render_conflict message: 'outpatient_service_type参数不正确' and return if ShareEnum.outpatient_services[user_info[:outpatient_service_type].to_sym].blank?
        user = User.find(user_info[:user_id])
        render_conflict message: '用户不存在' and return if user.blank?
        render_conflict message: user.name.to_s+'在'+ShareEnum.weeks[params[:week].to_sym].to_s+'的'+Office.find(office_time.office_id).try(:name).to_s+ShareEnum.am_pms[office_time.am_pm_code.to_sym]+'已经排班，不能再次添加' and return if Scheduling.alive.office_time_id_is(office_time.id).user_id_is(user.id).week_code_is(params[:week]).present?
        scheduling = Scheduling.new office_time_id: office_time.id, user_id: user.id, week_code: params[:week], outpatient_service_type: user_info[:outpatient_service_type]
        if scheduling.save
          collection.push({sheduling_id: scheduling.id, user_name: user.name})
        else
          render_conflict message: error_message(scheduling) and return
        end
      end
      render_ok collection: collection and return
    end
  end

  def destroy
    ActiveRecord::Base.transaction do
      render_conflict message: 'id参数错误' and return if params[:id].blank?
      scheduling = Scheduling.find(params[:id])
      render_conflict message: '找不到排班数据' and return if scheduling.blank?
      if scheduling.soft_destroy
        render_ok and return
      else
        render_conflict message: error_message(scheduling) and return
      end
    end
  end

end
