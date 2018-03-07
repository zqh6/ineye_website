module ErrorMessage

  extend ActiveSupport::Concern

  self.included do |includer|

    def error_message(obj)
      obj.class.human_attribute_name(obj.errors.messages.first[0].to_sym)+obj.errors.messages.first[1].first
    end

  end

end