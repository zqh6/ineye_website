class CreateDictionaries < ActiveRecord::Migration[5.0]
  def change
    create_table :dictionaries do |t|

      t.string :dictionary_type, null: false, default: '', limit: 50
      t.string :name, null: false, default: '', limit: 50
      t.string :code, null: false, default: '', limit: 50
      t.integer :value, null: false, default: 0

      t.column   :state, 'char(1)', null: false, default: 'C'
      t.datetime :opened_at,        null: false, default: ::Time.utc(1970)
      t.datetime :closed_at,        null: false, default: ::Time.utc(3000)
      t.boolean  :defunct,          null: false, default: false

      t.timestamps
    end

    add_index  :dictionaries, :dictionary_type
    add_index  :dictionaries, :code

  end
end
