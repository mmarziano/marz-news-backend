class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :googleId
  has_many :comments
  
end
