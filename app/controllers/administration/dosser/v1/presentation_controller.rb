class Administration::Dosser::V1::PresentationController < ActionController::Base

  clear_helpers

  include Repres::Dosser::Concerns::ResourcePresentation

  layout :nil

  before_action :validate_login

  def validate_login
    Rails.logger.warn session[:user].inspect
    @user = User.included_by(session[:user]['id']).first
  end

end
