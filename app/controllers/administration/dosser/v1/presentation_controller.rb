class Administration::Dosser::V1::PresentationController < ActionController::Base

  clear_helpers

  include Repres::Dosser::Concerns::ResourcePresentation, ControllerConcerns

  layout :nil

  before_action :validate_login

  def validate_login
    @login_user = User.included_by(session[:user_id]).first if session[:user_id].present?
  end

end
