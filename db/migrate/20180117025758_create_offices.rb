class CreateOffices < ActiveRecord::Migration[5.0]
  def change
    create_table :offices do |t|

      t.string :name,      null: false, default: ''
      t.string :vice_name, null: true

      t.column   :state, 'char(1)', null: false, default: 'C'
      t.datetime :opened_at,        null: false, default: ::Time.utc(1970)
      t.datetime :closed_at,        null: false, default: ::Time.utc(3000)
      t.boolean  :defunct,          null: false, default: false

      t.timestamps
    end
  end
end
