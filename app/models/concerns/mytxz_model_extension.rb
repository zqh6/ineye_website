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

    def to_json_by(fields: [])
      result = {}
      if fields.present?
        fields.each do |field|
          if field.to_sym == :created_at || field.to_sym == :updated_at
            result[field.to_sym] = self.try(field.to_sym).strftime('%Y-%m-%d %H:%M:%S')
          else
            result[field.to_sym] = self.try(field.to_sym)
          end
        end
      end
      result
    end

  end
end
