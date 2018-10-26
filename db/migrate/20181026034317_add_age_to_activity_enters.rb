class AddAgeToActivityEnters < ActiveRecord::Migration[5.0]
  def change
    add_column :activity_enters, :age, :string
  end
end
