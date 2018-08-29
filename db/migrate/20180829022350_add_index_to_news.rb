class AddIndexToNews < ActiveRecord::Migration[5.0]
  def change
    add_index :news, :title
    add_index :news, :classify
    add_index :news, :state
    add_index :news, :defunct
  end
end
