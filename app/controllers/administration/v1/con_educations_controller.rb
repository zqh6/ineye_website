class Administration::V1::ConEducationsController < Administration::V1::PrivilegedController

  def index
    @con_education_articles = ConEducationArticle.alive
    @con_education_articles = @con_education_articles.title_like(params[:title].to_s.strip) if params[:title].to_s.present?
    @con_education_articles = @con_education_articles.where('article_classify = ?', params[:article_classify]) if params[:article_classify].present? && params[:article_classify].to_s!='0'
    @con_education_articles = @con_education_articles.reorder('created_at DESC').paginate(page: params[:page], per_page: 20)
  end

  def show
  end

  def new
    @con_education_article = ConEducationArticle.new article_classify: 'special_lecture', article_type: 'video'
  end

  def edit
    @con_education_article = ConEducationArticle.find(params[:id])
  end

end
