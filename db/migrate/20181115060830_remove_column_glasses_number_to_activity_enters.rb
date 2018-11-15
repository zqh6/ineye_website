class RemoveColumnGlassesNumberToActivityEnters < ActiveRecord::Migration[5.0]
  def change
    remove_column :activity_enters, :glasses_number, :string
  end
end
