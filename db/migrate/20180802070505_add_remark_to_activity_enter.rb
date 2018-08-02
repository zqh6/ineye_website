class AddRemarkToActivityEnter < ActiveRecord::Migration[5.0]
  def change
    add_column :activity_enters, :remark, :string
  end
end
