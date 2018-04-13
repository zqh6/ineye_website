class Administration::Dosser::V1::ConEducationsController < Administration::Dosser::V1::PresentationController

  include ControllerConcerns

  def create
    ActiveRecord::Base.transaction do
      con_education_article = assign_attributes(p: params, object: ConEducationArticle.new)
      render_conflict message: '不要乱来，Okay?' and return if ShareEnum.con_education_article_classifies.collect{|a,b|a}.exclude?(con_education_article.article_classify)
      render_conflict message: '不要乱来，OK?' and return if ShareEnum.article_types.collect{|a,b|a}.exclude?(con_education_article.article_type)
      if con_education_article.static_url.blank?
        if con_education_article.article_type=='video'
          con_education_article.video_url = params[:video_url]
        elsif con_education_article.article_type=='pdf'
          con_education_article.pdf_url = params[:pdf_url]
        elsif con_education_article.article_type=='text'
          con_education_article.content = params[:content]
        end
      end
      if con_education_article.save
        tags = params[:tags].to_s.strip
        render_conflict message: '标签不要乱输入，Okay?' and return if (/\A(;|；)+\z/.match(tags)).present?
        deal_with_tags tags, con_education_article
        render_ok and return
      else
        render_conflict message: error_message(con_education_article) and return
      end
    end
  end

  def update
    ActiveRecord::Base.transaction do
      con_education_article = assign_attributes(p: params, object: ConEducationArticle.find(params[:id]))
      render_conflict message: '不要乱来，Okay?' and return if ShareEnum.con_education_article_classifies.collect{|a,b|a}.exclude?(con_education_article.article_classify)
      render_conflict message: '不要乱来，OK?' and return if ShareEnum.article_types.collect{|a,b|a}.exclude?(con_education_article.article_type)
      if con_education_article.static_url.blank?
        if con_education_article.article_type=='video'
          con_education_article.video_url = params[:video_url]
        elsif con_education_article.article_type=='pdf'
          con_education_article.pdf_url = params[:pdf_url]
        elsif con_education_article.article_type=='text'
          con_education_article.content = params[:content]
        end
      end
      if con_education_article.save
        TagRelation.where(relation_type: ConEducationArticle.name.underscore).where(relation_id: con_education_article.id).delete_all
        tags = params[:tags].to_s.strip
        render_conflict message: '标签不要乱输入，Okay?' and return if (/\A(;|；)+\z/.match(tags)).present?
        deal_with_tags tags, con_education_article
        render_ok and return
      else
        render_conflict message: error_message(con_education_article) and return
      end
    end
  end

  def assign_attributes(p: nil, object: nil)
    object.assign_attributes article_classify: p[:article_classify], article_type: p[:article_type], static_url: p[:static_url], title: p[:title], published_at: (p[:published_at].present? ? Date.parse(p[:published_at]) : nil)
    object
  end

end
