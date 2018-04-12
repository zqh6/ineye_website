class ConEducationArticle < ApplicationRecord

  scope :title_like,           ->(title)            { where "#{table_name}.title LIKE :title",     title: "%#{title}%" }
  scope :article_classify_is,  ->(article_classify) { where "#{table_name}.article_classify = :article_classify", article_classify: "#{article_classify}" }

  validates :title, presence: true

end
