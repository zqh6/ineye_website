class Administration::V1::DashboardsController < Administration::V1::PrivilegedController

  def show
    redirect_to administration_v1_users_path and return
  end

end
