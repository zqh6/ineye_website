class CreateSchedulings < ActiveRecord::Migration[5.0]
  def change
    create_table :schedulings do |t|

      t.integer :office_time_id, null: false
      t.integer :user_id, null: false
      t.string :week_code, null: false
      t.string :outpatient_service_type, null: true

      t.column   :state, 'char(1)', null: false, default: 'C'
      t.datetime :opened_at,        null: false, default: ::Time.utc(1970)
      t.datetime :closed_at,        null: false, default: ::Time.utc(3000)
      t.boolean  :defunct,          null: false, default: false

      t.timestamps
    end
  end
end
