class AddClassifyTagToNew < ActiveRecord::Migration[5.0]
  def change
    add_column :news, :classify_tag, :string
  end
end
