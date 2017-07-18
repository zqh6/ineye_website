class User < ApplicationRecord

  include Unidom::Common::Concerns::ModelExtension

  has_many :passwords
  belongs_to :role, class_name: 'Dictionary'

  scope :phone_number_is, ->(phone_number) { where "#{table_name}.phone_number = :phone_number ", phone_number: phone_number }

end
