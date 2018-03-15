class SearchWebsitesController < ApplicationController

  layout 'content'

  def index
    @search_value = params[:search_value].to_s.strip
    @collection = []
    return if @search_value.blank?
    doctors = User.alive.role_code_is('common_user').name_like(@search_value)
    doctors.each do |doctor|
      info = {}
      info[:name] = doctor.name
      info[:link] = '/doctors/'+doctor.id.to_s
      @collection.push(info)
    end

    news = New.alive.title_like(@search_value)
    news.each do |n|
      info = {}
      info[:name] = n.title
      info[:link] = n.scan_rails_path.present? ? n.scan_rails_path : '/news/'+n.id.to_s+'?from=db'
      @collection.push(info)
    end
  end
end
