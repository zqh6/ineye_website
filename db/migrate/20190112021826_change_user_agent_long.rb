class ChangeUserAgentLong < ActiveRecord::Migration[5.0]
  def change
    change_column :activity_enters, :user_agent, :string, limit: 500
  end
end
