class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|

      t.integer :parent_id
      t.string :content

      t.string :post_link
      t.string :post_id
      t.integer :creator_id
      t.integer :auditor_id

      t.column   :state, 'char(1)', null: false, default: 'C'
      t.boolean  :defunct,          null: false, default: false

      t.timestamps
    end
  end
end
