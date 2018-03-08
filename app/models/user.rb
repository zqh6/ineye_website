class User < ApplicationRecord

  has_many :passwords
  belongs_to :create_user, class_name: 'User', foreign_key: 'create_user_id', optional: true

  has_many :office_user_relations
  has_many :offices, through: :office_user_relations

  validates :name,
            presence: {message: '请填写您的姓名'},
            length: {minimum: 0, maximum: 4, message: '姓名最长为4位' }

  validates :phone_number,
            uniqueness: {message: '该手机号已经注册'},
            presence: {message: '请填写手机号'},
            numericality: {message: '手机号码应为数字' },
            length: {minimum: 11, maximum: 11, message: '手机号码应该为11位的数字' },
            format: {with: /\A1\d{10}\z/, message: '手机格式不正正确'}

  validates :role_code,    presence:   true

  scope :not_role_code,     ->(role_code)    { where "#{table_name}.role_code != :role_code", role_code: role_code }
  scope :phone_number_is,   ->(phone_number) { where "#{table_name}.phone_number = :phone_number ", phone_number: phone_number }
  scope :role_code_is,      ->(role_code)    { where "#{table_name}.role_code = :role_code ", role_code: role_code }
  scope :phone_number_like, ->(phone_number) { where "#{table_name}.phone_number LIKE :phone_number", phone_number: "%#{phone_number}%" }
  scope :name_like,         ->(name)         { where "#{table_name}.name LIKE :name", name: "%#{name}%" }
  scope :create_user_is,    ->(create_user)  { where "#{table_name}.create_user_id = :create_user_id", create_user_id: create_user.id }

  def get_office
    office_user_relation = OfficeUserRelation.alive.user_id_is(self.id).reorder('created_at DESC').first
    if office_user_relation.blank?
      nil
    else
      Office.find(office_user_relation.office_id)
    end
  end

  def self.get_users_by_office(office)
    office_user_relations = OfficeUserRelation.office_id_is(office.id)
    user_ids = []
    office_user_relations.each do |office_user_relation|
      user_ids.push(office_user_relation.user_id)
    end
    User.alive.where('id in (?)', user_ids)
  end

  def unit_name_desc
    if self.role_code.to_sym == :outer_user
      self.unit_name
    elsif [:user_admin, :sys_admin, :common_user].include?(self.role_code.to_sym) && self.official_account=='is'
      '银海眼科'
    end
  end
end
