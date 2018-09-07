class AddCreatorToBanner < ActiveRecord::Migration[5.0]
  def change
    add_column :banners, :operator_id, :integer
  end
end
