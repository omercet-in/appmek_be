module Mutations
  class SignIn < BaseMutation
    argument :phone_number, String, required: true
    argument :password, String, required: true

    field :token, String, null: false

    def resolve(phone_number:, password:)
      user = User.find_by(phone_number: phone_number)

      if user&.authenticate(password)
        token = JwtService.encode(user_id: user.id)
        { token: token }
      else
        raise GraphQL::ExecutionError, "Invalid phone number or password"
      end
    end
  end
end
