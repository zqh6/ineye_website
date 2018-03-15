class DoctorsController < ApplicationController
  def show
    @user = User.find(params[:id])
    redirect_to '/' and return if @user.role_code!='common_user'
  end
end
