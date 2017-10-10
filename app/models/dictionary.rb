class Dictionary < ApplicationRecord

  include Unidom::Common::Concerns::ModelExtension

  scope :dictionary_type_is, ->(dictionary_type) { where "#{table_name}.dictionary_type = :dictionary_type ", dictionary_type: dictionary_type  }
  scope :code_is, ->(code) { where "#{table_name}.code = :code ", code: code  }

end
