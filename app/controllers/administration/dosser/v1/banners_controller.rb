class Administration::Dosser::V1::BannersController < Administration::Dosser::V1::PresentationController

  include ControllerConcerns

  def create
    ActiveRecord::Base.transaction do
      banner = Banner.new banner_attributes
      banner.operator_id = @login_user.id
      render_conflict message: '请上传图片' and return if banner.image_url.blank?
      if banner.save
        render_ok and return
      else
        render_conflict message: error_message(banner) and return
      end
    end
  end

  def update
    ActiveRecord::Base.transaction do
      banner = Banner.find(params[:id])
      render_conflict message: '找不到轮播图' and return if banner.blank?
      old_image_url = banner.image_url
      banner.assign_attributes banner_attributes
      banner.image_url = old_image_url if params[:image_url].blank? && old_image_url.present?
      banner.operator_id = @login_user.id

      render_conflict message: '请上传图片' and return if banner.image_url.blank?
      if banner.save
        render_ok and return
      else
        render_conflict message: error_message(new) and return
      end
    end
  end


  def banner_attributes
    params.permit(:serial, :image_url, :aim_at_platform, :state, :link_url, :description)
  end

  private :banner_attributes

end
