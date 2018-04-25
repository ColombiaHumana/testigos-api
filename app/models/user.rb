class User < ApplicationRecord
  has_secure_password
  has_many :reset_tokens
end
