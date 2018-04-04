class ConEducationController < ApplicationController
  def show
    if ['专题讲座', '典型病例', '疑难病例', '手术视频'].include?(params[:id])

    else
      ActiveRecord::Base.transaction do
        redirect_to logins_path and return if session[:user].blank?
        relative_path = URI.decode(request.fullpath).strip
        @url_count = UrlCount.where(url: relative_path).first
        if @url_count.present?
          @url_count.count = @url_count.count + 1
          @url_count.save!
        else
          @url_count = UrlCount.new url: relative_path, method: request.request_method, count: 1
          @url_count.save!
        end
      end
    end
    render  layout: "content",:action => params[:id] and return
  end
end

