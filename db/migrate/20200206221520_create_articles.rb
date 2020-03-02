class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :author
      t.string :title
      t.string :description
      t.string :url
      t.string :urlToImage
      t.string :publishedAt
      t.string :content
      t.string :source
      t.integer :timesSaved
      t.integer :user_id

      t.timestamps
    end
  end
end
