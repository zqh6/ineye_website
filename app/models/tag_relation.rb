class TagRelation < ApplicationRecord

  def self.get_tags_by(object: nil)
    result = ''
    TagRelation.where('relation_type = ?', object.class.name.underscore).where('relation_id = ?', object.id).each do |tag_relation|
      result = result+'；'+tag_relation.tag_name
    end
    if result[0]=='；'
      result[0]=''
    end
    result
  end
end
