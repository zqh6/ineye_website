require 'csv'
class Administration::V1::UsersController < Administration::V1::PrivilegedController

  def show
    render :action => params[:id]
  end

  def edit
    @user = User.find(params[:id])
    @user_office_ids = OfficeUserRelation.alive.user_id_is(@user.id).reorder('created_at DESC').collect{|i| i.office_id}
    @offices = Office.alive
  end

  def new
    @offices = Office.alive
    @user = User.new role_code: 'user_admin'
  end

  def index
    users = User.alive.reorder('created_at DESC')
    if params[:export_file]=='true'
      csv = CSV.generate do |csv|
        csv << [ (User.human_attribute_name :name), (User.human_attribute_name :phone_number), (User.human_attribute_name :role_code), (User.human_attribute_name :unit_name), (User.human_attribute_name :created_at)]
        users.each do |user|
          row_data =[user.name, user.phone_number, ShareEnum.roles[user.role_code.to_sym], user.unit_name, user.created_at_desc]
          csv << row_data
        end
      end.encode('gb2312', :invalid => :replace, :undef => :replace, :replace => "?")
      send_data csv, filename: '用户数据'+Time.now.strftime('%Y-%m-%d %H-%M-%S')+'.csv' and return
    end

    @users = User.alive.not_role_code('sys_admin').not_role_code('outer_user')
    if @login_user.role_code=='sys_admin'
      @users = User.alive.not_role_code('sys_admin')
    end
    @users = @users.phone_number_like(params[:phone_number]) if params[:phone_number].present?
    @users = @users.name_like(params[:name])                 if params[:name].present?
    @users = @users.reorder('created_at DESC').paginate(page: params[:page], per_page: 20)
  end

end
