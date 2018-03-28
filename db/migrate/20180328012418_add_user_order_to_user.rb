class AddUserOrderToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :user_order, :integer, null: true, default: 0
  end
end
