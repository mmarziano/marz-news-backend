class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :oauthID, :profileImg
  has_many :comments
  
end
