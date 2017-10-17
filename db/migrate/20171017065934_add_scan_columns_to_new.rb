class AddScanColumnsToNew < ActiveRecord::Migration[5.0]
  def change
    add_column :news,    :scan_file_id,    :string, null: true, default: nil, limit: 255
    add_column :news,    :scan_rails_path, :string, null: true, default: nil, limit: 255
    change_column :news, :user_id, :integer, null: true, default: nil
  end
end
