module MytxzModelExtension

  extend ActiveSupport::Concern

  included do |includer|
    scope :included_by, ->(inclusion) { where     id: inclusion }
    scope :excluded_by, ->(exclusion) { where.not id: exclusion }

    scope :valid_at, ->(now: Time.now) { where "? BETWEEN #{includer.table_name}.opened_at AND #{includer.table_name}.closed_at", now }
    scope :alive,    ->(living:  true) { where defunct: !living }

    def soft_destroy!
      self.closed_at = Time.now
      self.defunct = true
      self.save!
    end
  end
end