class AddNewReadCountToNew < ActiveRecord::Migration[5.0]
  def change
    add_column :news, :read_count, :integer
  end
end
