class Administration::V1::LeavingsController < Administration::V1::PrivilegedController

  def new
    if params[:function]=='all_user'
      @offices = Office.alive
      @ask_for_leaves_query = AskForLeave.alive.reorder('created_at DESC').paginate(page: params[:page], per_page: 20)
      @ask_for_leaves = show_ask_for_leaves @ask_for_leaves_query
      render action: 'new' and return
    elsif params[:function]=='one_user'
      @office = @login_user.get_office
      @ask_for_leaves_query = AskForLeave.alive.where(user_id: @login_user.id).reorder('created_at DESC').paginate(page: params[:page], per_page: 20)
      @ask_for_leaves = show_ask_for_leaves @ask_for_leaves_query
      render action: 'onenew' and return
    end
  end

  def show_ask_for_leaves(ask_for_leaves)
    @ask_for_leaves = []
    user_id_keys= []
    user_id_hash={}
    ask_for_leaves.each do |ask_for_leave|
      ask_for_leave_item = {}
      if user_id_keys.include? ask_for_leave.user_id
        user = user_id_hash[ask_for_leave.user_id.to_s.to_sym]
      else
        user = User.find(ask_for_leave.user_id)
        user_id_keys.push(ask_for_leave.user_id)
        user_id_hash[ask_for_leave.user_id.to_s.to_sym]=user
      end
      ask_for_leave_item[:user_name] = user.name
      ask_for_leave_item[:office_name]=user.get_office.name
      ask_for_leave_item[:am_pm_code_desc]=ShareEnum.am_pms[ask_for_leave.am_pm_code.to_sym]
      ask_for_leave_item[:day]=ask_for_leave.day.strftime('%Y-%m-%d')
      ask_for_leave_item[:created_at_desc]=ask_for_leave.created_at_desc
      @ask_for_leaves.push(ask_for_leave_item)
    end
    @ask_for_leaves
  end

end
