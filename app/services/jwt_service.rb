class JwtService
    HMAC_SECRET = Rails.application.secret_key_base # Use your application's secret key
  
    def self.encode(payload)
        JWT.encode(payload, HMAC_SECRET)
    end
  
    def self.decode(token)
        body = JWT.decode(token, HMAC_SECRET)[0]
        HashWithIndifferentAccess.new(body)
    rescue JWT::DecodeError
        nil
    end
end
  