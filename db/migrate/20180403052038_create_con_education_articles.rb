class CreateConEducationArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :con_education_articles do |t|

      t.string :article_classify, null: false
      t.string :article_type,     null: false
      t.string :static_url, null: true

      t.string :title,   null: false
      t.string :content, null: true

      t.string :pdf_url,   null: true
      t.string :video_url, null: true

      t.datetime :published_at, null: false

      t.column   :state, 'char(1)', null: false, default: 'C'
      t.datetime :opened_at,        null: false, default: ::Time.utc(1970)
      t.datetime :closed_at,        null: false, default: ::Time.utc(3000)
      t.boolean  :defunct,          null: false, default: false

      t.timestamps
    end

    add_index :con_education_articles, :article_classify
    add_index :con_education_articles, :article_type
    add_index :con_education_articles, :static_url
    add_index :con_education_articles, :title
    add_index :con_education_articles, :published_at
  end
end
