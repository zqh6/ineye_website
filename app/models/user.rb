class User < ApplicationRecord

  has_many :passwords
  belongs_to :create_user, class_name: 'User', foreign_key: 'create_user_id'

  validates :phone_number, presence:   true, uniqueness: true
  validates :role_code,    presence:   true

  scope :not_role_code,     ->(role_code)    { where "#{table_name}.role_code != :role_code", role_code: role_code }
  scope :phone_number_is,   ->(phone_number) { where "#{table_name}.phone_number = :phone_number ", phone_number: phone_number }
  scope :phone_number_like, ->(phone_number) { where "#{table_name}.phone_number LIKE :phone_number", phone_number: "%#{phone_number}%" }
  scope :name_like,         ->(name)         { where "#{table_name}.name LIKE :name", name: "%#{name}%" }
  scope :create_user_is,    ->(create_user)  { where "#{table_name}.create_user_id = :create_user_id", create_user_id: create_user.id }
end
