class ConEducationsController < ApplicationController

  layout 'content'

  def show
    if ['专题讲座', '典型病例', '疑难病例', '手术视频'].include?(params[:id])

    else
      ActiveRecord::Base.transaction do
        redirect_to logins_path and return if session[:user_id].blank?
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
      if params[:new]=='true'
        @con_education_article = ConEducationArticle.find(params[:id])
        render action: :show_text and return if @con_education_article.article_type=='text'
        render action: :show_pdf and return if @con_education_article.article_type=='pdf'
        render action: :show_video and return if @con_education_article.article_type=='video'
      end
    end
    render :action => params[:id] and return
  end

  def index
    @con_education_articles = ConEducationArticle.alive.article_classify_is(params[:article_classify])
    if params[:doctor_name].present?
      relation_ids = TagRelation.relation_type_is(ConEducationArticle.name.underscore).tag_flag_is('doctor_name').collect{|i|i.relation_id}
      @con_education_articles = @con_education_articles.where('id in (?)', relation_ids)
    end
    @user_names = User.alive.role_code_is('common_user').collect{|i| i.name.to_s.strip}
  end
end

