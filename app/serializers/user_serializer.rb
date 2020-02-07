class UserSerializer < ActiveModel::Serializer
  attributes :id
  has_many :comments
  has_many :articles
end
