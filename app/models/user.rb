class User < ApplicationRecord
  has_secure_password :password
  validates :username, :password_digest, presence: true
  validates :username, uniqueness: true
  #validates :password, format: { with: PASSWORD_FORMAT }
  #validates :password, length: { minimum: 8 }
end