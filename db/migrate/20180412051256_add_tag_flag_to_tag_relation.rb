class AddTagFlagToTagRelation < ActiveRecord::Migration[5.0]
  def change
    add_column :tag_relations, :tag_flag, :string, null: true
    add_index :tag_relations, :tag_flag
  end
end
