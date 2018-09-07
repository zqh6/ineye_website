class Administration::V1::BannersController < Administration::V1::PrivilegedController

  def new
    @banner = Banner.new state: 1, aim_at_platform: 'pc_and_mobile'
  end

  def edit
    @banner = Banner.find(params[:id])
  end

  def index
    @banners = Banner.all
    @banners = @banners.reorder('state desc, serial asc, created_at desc').paginate(page: params[:page], per_page: 10)
  end

end
