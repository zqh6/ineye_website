class ConEducationArticle < ApplicationRecord

  scope :title_like,  ->(title)    { where "#{table_name}.title LIKE :title",     title: "%#{title}%" }

  validates :title, presence: true

end
