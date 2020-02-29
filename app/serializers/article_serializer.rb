class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :author, :title, :description, :url, :urlToImage, :publishedAt, :content, :source, :user_id
  has_many :comments
  has_many :users
end
