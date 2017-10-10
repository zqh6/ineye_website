class NewClassify < ActiveRecord::Type::Value

  include ProgneTapera::EnumConfig

  enum :new_classify, :new_classify

end