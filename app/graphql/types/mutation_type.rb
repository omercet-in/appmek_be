# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    # TODO: remove me
    field :create_user, UserType, null: false do
      argument :full_name, String, required: true
      argument :phone_number, String, required: true
      argument :password, String, required: true
    end

    def create_user(full_name:, phone_number:, password:)
      User.create!(full_name: full_name, phone_number: phone_number, password: password)
    end

    field :send_otp, mutation: Mutations::SendOtp
    field :verify_otp, mutation: Mutations::VerifyOtp
    field :sign_in, mutation: Mutations::SignIn
  end
end
