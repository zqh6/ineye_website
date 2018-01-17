class CreateAskForLeaves < ActiveRecord::Migration[5.0]
  def change
    create_table :ask_for_leaves do |t|

      t.integer :user_id, null: false
      t.string :am_pm_code, null: false
      t.datetime :day, null: false

      t.column   :state, 'char(1)', null: false, default: 'C'
      t.datetime :opened_at,        null: false, default: ::Time.utc(1970)
      t.datetime :closed_at,        null: false, default: ::Time.utc(3000)
      t.boolean  :defunct,          null: false, default: false

      t.timestamps
    end
  end
end
