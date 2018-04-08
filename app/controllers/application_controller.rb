class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :check_browser

  def check_browser
=begin
    user_agent = request.env['HTTP_USER_AGENT']
    if user_agent.include?('iPhone')||user_agent.include?('Android')||user_agent.include?('iPad')
      redirect_to 'http://m.ineyehospital.com/' and return
    end
=end
    @login_user = nil
    @login_user = User.included_by(session[:user_id]).first if session[:user_id].present?
  end

end
