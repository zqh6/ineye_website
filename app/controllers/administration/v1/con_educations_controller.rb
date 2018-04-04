class Administration::V1::ConEducationsController < Administration::V1::PrivilegedController

  def index
  end

  def show
  end

  def new
    @con_education_article = ConEducationArticle.new
  end

  def edit
  end

end
