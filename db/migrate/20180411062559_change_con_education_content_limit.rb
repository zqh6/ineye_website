class ChangeConEducationContentLimit < ActiveRecord::Migration[5.0]
  def change
    change_column :con_education_articles, :content, :text, limit: 107772150
  end
end
