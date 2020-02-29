class ArticlesAndUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :articles_users, id: false do |t|
      t.bigint :article_id
      t.bigint :user_id
    end
 
  end
end
