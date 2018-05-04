class ChangePublishedAtToAtAboutArticle < ActiveRecord::Migration[5.0]
  def change
    change_column :con_education_articles, :published_at, :datetime, null: true
  end
end
