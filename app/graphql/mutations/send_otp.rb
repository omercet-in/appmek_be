module Mutations
  class SendOtp < BaseMutation
    argument :phone_number, String, required: true
    argument :full_name, String, required: false
    argument :password, String, required: false

    field :success, Boolean, null: false

    def resolve(phone_number:, full_name: nil, password: nil)
      user = User.find_or_initialize_by(phone_number: phone_number)

      user.full_name = full_name if user.new_record? && full_name.present?
      user.password = password if user.new_record? && password.present?

      if user.save
        OtpService.new(user).send_otp
        { success: true }
      else
        raise GraphQL::ExecutionError.new("Invalid input: #{user.errors.full_messages.join(', ')}")
      end
    end
  end
end
