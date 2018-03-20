class AddOfficeIdToScheduling < ActiveRecord::Migration[5.0]
  def change
    add_column :schedulings, :office_id, :integer, null: false
    add_column :schedulings, :am_pm_code, :string, null: false
    add_index :schedulings, :office_id
    add_index :schedulings, :am_pm_code
  end
end
