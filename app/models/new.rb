class New < ApplicationRecord

  belongs_to :user

  scope :classify_is,        ->(classify) { where "#{table_name}.classify = :classify ", classify: classify  }
  scope :scan_rails_path_is, ->(scan_rails_path) { where "#{table_name}.scan_rails_path = :scan_rails_path ", scan_rails_path: scan_rails_path  }
  scope :classify_is_not,    ->(classify) { where "#{table_name}.classify != :classify ", classify: classify  }
  scope :title_like,         ->(title)    { where "#{table_name}.title LIKE :title", title: "%#{title}%" }
  scope :classify_tag_like,         ->(classify_tag)    { where "#{table_name}.classify_tag LIKE :classify_tag", classify_tag: "%#{classify_tag}%" }
  scope :content_like,       ->(content)  { where "#{table_name}.content LIKE :content", content: "%#{content}%" }

end
