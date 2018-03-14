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
    @user = User.new
  end

  def index
    user = User.included_by(session[:user]['id']).first
    @users = User.alive.not_role_code('1')
=begin
    if session[:user]['role_code']!='1'
      @users = @users.create_user_is(user)
    end
=end
    @users = @users.phone_number_like(params[:phone_number]) if params[:phone_number].present?
    @users = @users.name_like(params[:name])                 if params[:name].present?
    @users = @users.reorder('created_at DESC').paginate(page: params[:page], per_page: 20)
  end

end
