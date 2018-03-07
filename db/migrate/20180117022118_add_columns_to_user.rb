class AddColumnsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :linked_url,     :string, null: true

    add_column :users, :honour_brief_introduction, :text, null: true
    add_column :users, :honour_specific,           :text, null: true
    add_column :users, :good_at_field,             :text, null: true
    add_column :users, :work_time,                 :text, null: true
    add_column :users, :detailed_introduction,     :text, null: true

  end
end
