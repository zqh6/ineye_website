class AddGlassesNumberOneToActivityEnters < ActiveRecord::Migration[5.0]
  def change
    add_column :activity_enters, :glasses_number_one, :string
  end
end
