class CreateDictionaries < ActiveRecord::Migration[5.0]
  def change
    create_table :dictionaries, id: :uuid do |t|

      t.string :dictionary_type, null: false, default: '', limit: 50
      t.string :name, null: false, default: '', limit: 50
      t.string :code, null: false, default: '', limit: 50
      t.integer :value, null: false, default: 0

      t.timestamps
    end
  end
end
