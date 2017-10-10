class New < ApplicationRecord

  include Unidom::Common::Concerns::ModelExtension

  belongs_to :user

  scope :classify_is, ->(classify) { where "#{table_name}.classify = :classify ", classify: classify  }
  scope :title_like,  ->(title)    { where "#{table_name}.title LIKE :title",     title: "%#{title}%" }

end
