class Administration::V1::PrivilegedController < ::ApplicationController

  layout 'administration/v1'

  helper :administration

  before_action :validate_login

  def validate_login
    if session[:user_id].blank?
      redirect_to new_administration_v1_session_path and return
    else
      @login_user = User.find(session[:user_id])
    end
  end

end
