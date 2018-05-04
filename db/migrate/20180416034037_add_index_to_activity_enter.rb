class AddIndexToActivityEnter < ActiveRecord::Migration[5.0]
  def change
    add_index :activity_enters, :name
    add_index :activity_enters, :phone_number
    add_index :activity_enters, :activity_type
  end
end
