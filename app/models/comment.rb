class Comment < ApplicationRecord

  scope :post_id_is, ->(post_id) { where "#{table_name}.post_id = :post_id ", post_id: post_id }
  scope :post_link_is, ->(post_link) { where "#{table_name}.post_link = :post_link ", post_link: post_link }
  scope :parent_id_is, ->(parent_id) { where "#{table_name}.parent_id = :parent_id ", parent_id: parent_id }

end
