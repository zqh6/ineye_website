class AddOfficialAccountToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :official_account, :string, null: false
  end
end
