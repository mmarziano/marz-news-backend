class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :oauthID, :profileImg, :preferences_categories, :preferences_language
  has_many :comments
  has_many :articles
end
