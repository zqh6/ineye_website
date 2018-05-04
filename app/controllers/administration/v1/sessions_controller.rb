class Administration::V1::SessionsController < ::ApplicationController

  layout 'administration/v1'

  helper :administration

  def new
    redirect_to administration_v1_dashboard_path('~') if session[:user_id].present?
  end

end
