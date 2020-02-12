class User < ApplicationRecord
  has_secure_password :password
  validates :username, :password_digest, presence: true
  #validates :username, uniqueness: true, case_sensitive: true
  validates_uniqueness_of :username, case_sensitive: true
  #validates :password, format: { with: PASSWORD_FORMAT }
  #validates :password, length: { minimum: 8 }
end