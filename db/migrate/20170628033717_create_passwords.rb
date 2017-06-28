class CreatePasswords < ActiveRecord::Migration[5.0]
  def change
    create_table :passwords do |t|

      t.references :user,  type: :uuid, null: false

      t.column   :pepper_content, 'char(128)', null: false, default: ''
      t.column   :hashed_content, 'char(128)', null: false, default: ''

      t.column   :state, 'char(1)', null: false, default: 'C'
      t.datetime :opened_at,        null: false, default: ::Time.utc(1970)
      t.datetime :closed_at,        null: false, default: ::Time.utc(3000)
      t.boolean  :defunct,          null: false, default: false
      t.jsonb    :notation,         null: false, default: {}

      t.timestamps
    end
  end
end
