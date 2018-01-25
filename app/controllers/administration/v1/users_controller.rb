class Administration::V1::UsersController < Administration::V1::PrivilegedController

  def show
    render :action => params[:id]
  end

  def edit
  end

  def new
    @user = User.new
  end

  def index
    user = User.included_by(session[:user]['id']).first
    @users = User.alive.not_role_code('1')
    if session[:user]['role_code']!='1'
      @users = @users.create_user_is(user)
    end
    @users = @users.phone_number_like(params[:phone_number]) if params[:phone_number].present?
    @users = @users.name_like(params[:name])                 if params[:name].present?
    @users = @users.paginate(page: params[:page], per_page: 20)
  end

end
