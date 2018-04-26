class User < ApplicationRecord
  has_secure_password
  has_many :reset_tokens
  has_many :tables
  belongs_to :department
  belongs_to :municipality
  belongs_to :zone
  belongs_to :post
end
