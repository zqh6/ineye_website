class ChangeUrlValueLong < ActiveRecord::Migration[5.0]
  def change
    change_column :url_counts, :url, :string, limit: 500
  end
end
