class AddOfficeIdToAskForLeave < ActiveRecord::Migration[5.0]
  def change
    add_column :ask_for_leaves, :office_id, :integer, null: false, default: 0
  end
end
