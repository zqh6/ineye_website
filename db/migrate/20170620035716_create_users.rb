class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users, id: :uuid do |t|

      t.references :user, :create_user, type: :uuid, null: true

      t.string   :role_code,    null: true,  default: '', limit: 20
      t.string   :name,         null: true,  default: nil, limit: 50
      t.string   :phone_number, null: false, default: '', limit: 50

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
