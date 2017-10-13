class CreateNews < ActiveRecord::Migration[5.0]
  def change
    create_table :news do |t|

      t.references :user, type: :integer, null: false

      t.string   :title,       null: false, default: '',  limit: 255
      t.string   :vice_title,  null: true,  default: nil, limit: 255
      t.string   :key_words,   null: true,  default: nil, limit: 255
      t.datetime :occurred_at, null: false, default: ::Time.utc(1970)
      t.string   :classify,    null: true,  default: nil, limit: 255
      t.text     :content

      t.column   :state, 'char(1)', null: false, default: 'C'
      t.datetime :opened_at,        null: false, default: ::Time.utc(1970)
      t.datetime :closed_at,        null: false, default: ::Time.utc(3000)
      t.boolean  :defunct,          null: false, default: false

      t.timestamps
    end
  end
end
