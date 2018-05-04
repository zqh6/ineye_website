class ChangeUrlValueLong < ActiveRecord::Migration[5.0]
  def change
    remove_index :url_counts, :column => :url
    change_column :url_counts, :url, :string, limit: 500
  end
end
