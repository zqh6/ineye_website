class AddPreTimeToActivityEnter < ActiveRecord::Migration[5.0]
  def change
    add_column :activity_enters, :pre_time, :string
  end
end
