class ChangeNewContentLimit < ActiveRecord::Migration[5.0]
  def change

    change_column :news, :content, :text, limit: 1294967295
  end
end
