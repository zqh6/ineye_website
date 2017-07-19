class Administration::V1::UsersController < Administration::V1::PrivilegedController

  def show
  end

  def edit
  end

  def new
    @user = User.new
  end

  def index
    @users = User.alive.not_role_code('1')
    @users = @users.phone_number_like(params[:phone_number]) if params[:phone_number].present?
    @users = @users.name_like(params[:name])                 if params[:name].present?
    @users = @users.paginate(page: params[:page], per_page: 20)
  end

end
