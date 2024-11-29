module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :full_name, String, null: false
    field :phone_number, String, null: false
  end
end
