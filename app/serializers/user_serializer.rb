# app/serializers/user_serializer.rb
class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :firstname, :lastname, :role, :confirmed

  def confirmed
    object.confirmed?
  end
end