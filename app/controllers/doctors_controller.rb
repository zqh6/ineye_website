class DoctorsController < ApplicationController

  layout 'content'

  def show
    @user = User.find(params[:id])
    redirect_to '/' and return if @user.role_code!='common_user'
  end

  def index
    @doctors = User.alive.role_code_is('common_user').where('doctor_level = ?', params[:doctor_level]).reorder('user_order DESC')
  end
end
