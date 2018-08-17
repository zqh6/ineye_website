class AddIpInfoToActivityEnter < ActiveRecord::Migration[5.0]
  def change
    add_column :activity_enters, :ip, :string, null: true
    add_column :activity_enters, :remote_ip, :string, null: true
    add_column :activity_enters, :user_agent, :string, null: true
  end
end
