class CreateBanners < ActiveRecord::Migration[5.0]
  def change
    create_table :banners do |t|

      t.integer :serial, default: 0, null: false
      t.string  :image_url
      t.string  :link_url
      t.string  :description
      t.integer :state
      t.string  :aim_at_platform

      t.timestamps
    end
  end
end
