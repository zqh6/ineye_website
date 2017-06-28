class User < ApplicationRecord

  include Unidom::Common::Concerns::ModelExtension

  has_many :passwords

  scope :phone_number_is, ->(phone_number) { where "#{table_name}.phone_number = :phone_number ", phone_number: phone_number }

end
