class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users, id: :uuid do |t|

      t.string   :name,         null: true,  default: nil, limit: 255
      t.string   :nick_name,    null: true,  default: nil, limit: 255
      t.string   :phone_number, null: false, default: '', limit: 255

      t.column  :role_code,     'char(1)', null: false, default: 'C'

      t.column   :state, 'char(1)', null: false, default: 'C'
      t.datetime :opened_at,        null: false, default: ::Time.utc(1970)
      t.datetime :closed_at,        null: false, default: ::Time.utc(3000)
      t.boolean  :defunct,          null: false, default: false
      t.jsonb    :notation,         null: false, default: {}

      t.timestamps
    end

    add_index  :users, :name
    add_index  :users, :phone_number

  end
end
