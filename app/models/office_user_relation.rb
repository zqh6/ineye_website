class OfficeUserRelation < ApplicationRecord

  belongs_to :user
  belongs_to :office

  scope :office_id_is, ->(office_id) { where office_id: office_id}
  scope :user_id_is, ->(user_id) { where user_id: user_id}
end
