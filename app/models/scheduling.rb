class Scheduling < ApplicationRecord

  scope :office_time_id_is,   ->(office_time_id) { where "#{table_name}.office_time_id = :office_time_id ", office_time_id: office_time_id }
  scope :user_id_is,   ->(user_id) { where "#{table_name}.user_id = :user_id ", user_id: user_id }
  scope :week_code_is,   ->(week_code) { where "#{table_name}.week_code = :week_code ", week_code: week_code }

end
