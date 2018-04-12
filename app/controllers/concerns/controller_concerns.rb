module ControllerConcerns

  extend ActiveSupport::Concern

  self.included do |includer|

    def deal_with_tags tags, object
      if tags.present?
        tag_arr = tags.split(/[;；]/)
        user_names = User.alive.role_code_is('common_user').collect{|i| i.name.to_s.strip}
        tag_arr.each do |tag_name|
          tag_name = tag_name.to_s.strip
          if tag_name.present?
            tag_relation = TagRelation.new relation_type: object.class.name.underscore, relation_id: object.id, tag_name: tag_name, tag_flag: (user_names.include?(tag_name) ? 'doctor_name' : '')
            tag_relation.save!
          end
        end if tag_arr.present?
      end
    end

  end

end