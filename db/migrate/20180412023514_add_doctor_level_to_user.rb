class AddDoctorLevelToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :doctor_level, :string, null: true
    add_index :users, :doctor_level
  end

end
