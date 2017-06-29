class Administration::V1::PrivilegedController < ::ApplicationController

  layout 'administration/v1'

  helper :administration

  before_action :validate_login

  def validate_login
    redirect_to new_administration_v1_session_path and return if session[:user].blank?
  end

end
