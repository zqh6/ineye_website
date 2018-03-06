class ChangeCommentContentType < ActiveRecord::Migration[5.0]
  def change
    change_column :comments, :content, :text, limit: 107772150
  end
end
