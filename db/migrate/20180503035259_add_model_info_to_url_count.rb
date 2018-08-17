class AddModelInfoToUrlCount < ActiveRecord::Migration[5.0]
  def change
    add_column :url_counts, :model_name2, :string
    add_column :url_counts, :model_id,   :integer
    add_index :url_counts, :model_name2
    add_index :url_counts, :model_id
  end
end
