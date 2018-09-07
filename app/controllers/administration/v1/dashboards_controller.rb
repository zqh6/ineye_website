class Administration::V1::DashboardsController < Administration::V1::PrivilegedController

  def show
    redirect_to administration_v1_banners_path and return
  end

end
