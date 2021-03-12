class UserSerializer
  include JSONAPI::Serializer

  set_type :user
  attributes :id, :email, :role, :activated, :activated_at
end