class CreateUrlCounts < ActiveRecord::Migration[5.0]
  def change
    create_table :url_counts do |t|

      t.string  :url,    default: '', null: false
      t.string  :suffix_params, default: '', null: false
      t.string  :method, default: '', null: false
      t.integer :count,  default: 0,  null: false

      t.column   :state, 'char(1)', null: false, default: 'C'
      t.datetime :opened_at,        null: false, default: ::Time.utc(1970)
      t.datetime :closed_at,        null: false, default: ::Time.utc(3000)
      t.boolean  :defunct,          null: false, default: false

      t.timestamps
    end

    add_index :url_counts, :url

  end
end
