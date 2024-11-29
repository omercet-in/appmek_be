class User < ApplicationRecord
  has_secure_password
  validates :phone_number, presence: true, uniqueness: true
end
