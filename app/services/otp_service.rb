require 'twilio-ruby'

class OtpService
    def initialize(user)
        @user = user
        @twilio_client = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
    end

    def send_otp
        otp = generate_otp
        @user.update(otp: otp, otp_sent_at: Time.current)
        send_sms(otp)
    end

    def verify_otp(otp)
        return false if @user.otp_sent_at < 1.day.ago
        @user.otp == otp
    end

    private 

    def generate_otp
        SecureRandom.random_number(10**4).to_s.rjust(4, '0')
    end

    def send_sms(otp)
        puts otp
        # @twilio_client.messages.create(
        #     from: ENV['TWILIO_PHONE_NUMBER'],
        #     to: @user.phone_number,
        #     body: "Your OTP for appmek is #{otp}"
        # )
    end
end