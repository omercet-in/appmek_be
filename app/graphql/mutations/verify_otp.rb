module Mutations
  class VerifyOtp < BaseMutation
    argument :phone_number, String, required: true
    argument :otp, String, required: true

    field :token, String, null: false
    field :user, Types::UserType, null:false

    def resolve(phone_number:, otp:)
      user = User.find_by(phone_number: phone_number)

      if user && OtpService.new(user).verify_otp(otp)
        token = JwtService.encode(user_id: user.id)
        {user: user, token: token}
      else
        raise GraphQL::ExecutionError, "Invalid OTP or phone number"
      end
    end
  end
end