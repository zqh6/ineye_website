class Password < ApplicationRecord

  include Unidom::Common::Concerns::ModelExtension

  belongs_to :user

end
