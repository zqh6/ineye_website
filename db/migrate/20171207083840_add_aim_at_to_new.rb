class AddAimAtToNew < ActiveRecord::Migration[5.0]
  def change
    add_column :news, :aim_at_platform, :string, null: true, default: nil, limit: 255
  end
end
