class TagRelation < ApplicationRecord

  scope :relation_type_is,  ->(relation_type) { where "#{table_name}.relation_type = :relation_type", relation_type: "#{relation_type}" }
  scope :relation_id_is,  ->(relation_id) { where "#{table_name}.relation_id = :relation_id", relation_id: "#{relation_id}" }
  scope :tag_flag_is,  ->(tag_flag) { where "#{table_name}.tag_flag = :tag_flag", tag_flag: "#{tag_flag}" }
  scope :tag_name_is,  ->(tag_name) { where "#{table_name}.tag_name = :tag_name", tag_name: "#{tag_name}" }


  def self.get_tags_by(object: nil)
    result = ''
    TagRelation.relation_type_is(object.class.name.underscore).relation_id_is(object.id).each do |tag_relation|
      result = result+'；'+tag_relation.tag_name
    end
    if result[0]=='；'
      result[0]=''
    end
    result
  end

  def self.get_doctor_names_by(object: nil)
    TagRelation.tag_flag_is('doctor_name').relation_type_is(object.class.name.underscore).relation_id_is(object.id).collect{|i| i.tag_name}.uniq
  end
end
