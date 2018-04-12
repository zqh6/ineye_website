class CreateTagRelations < ActiveRecord::Migration[5.0]
  def change
    create_table :tag_relations do |t|

      t.string :relation_type, null: false
      t.string :relation_id,   null: false
      t.string :tag_name,      null: false

      t.column   :state, 'char(1)', null: false, default: 'C'
      t.datetime :opened_at,        null: false, default: ::Time.utc(1970)
      t.datetime :closed_at,        null: false, default: ::Time.utc(3000)
      t.boolean  :defunct,          null: false, default: false

      t.timestamps
    end

    add_index :tag_relations, :relation_type
    add_index :tag_relations, :relation_id
    add_index :tag_relations, :tag_name
  end
end
