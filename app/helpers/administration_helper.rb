module AdministrationHelper
  def article_show(con_education_article: nil)
    con_education_article.static_url.to_s.strip.present? ? con_education_article.static_url : (con_education_article.article_type=='pdf' ? con_education_path(con_education_article.id, new: 'true', file: URI.encode(con_education_article.pdf_url)) : con_education_path(con_education_article.id, new: 'true'))
  end
end
