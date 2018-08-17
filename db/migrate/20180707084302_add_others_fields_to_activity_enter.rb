class AddOthersFieldsToActivityEnter < ActiveRecord::Migration[5.0]
  def change
    add_column :activity_enters, :dian_hua, :string
    add_column :activity_enters, :ordered_at, :datetime
    add_column :activity_enters, :description, :string
  end
end
