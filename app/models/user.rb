class User < ApplicationRecord

  has_many :passwords
  belongs_to :create_user, class_name: 'User', foreign_key: 'create_user_id', optional: true

  validates :phone_number,
            uniqueness: {message: '该手机号已经注册'},
            presence: {message: '请填写手机号'},
            numericality: {message: '手机号码应为数字' },
            length: {minimum: 11, maximum: 11, message: '手机号码应该为11位的数字' },
            format: {with: /\A1\d{10}\z/, message: '手机格式不正正确'}
  validates :role_code,    presence:   true

  scope :not_role_code,     ->(role_code)    { where "#{table_name}.role_code != :role_code", role_code: role_code }
  scope :phone_number_is,   ->(phone_number) { where "#{table_name}.phone_number = :phone_number ", phone_number: phone_number }
  scope :phone_number_like, ->(phone_number) { where "#{table_name}.phone_number LIKE :phone_number", phone_number: "%#{phone_number}%" }
  scope :name_like,         ->(name)         { where "#{table_name}.name LIKE :name", name: "%#{name}%" }
  scope :create_user_is,    ->(create_user)  { where "#{table_name}.create_user_id = :create_user_id", create_user_id: create_user.id }
end
