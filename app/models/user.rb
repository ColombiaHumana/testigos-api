class User < ApplicationRecord
  has_secure_password
  belongs_to :post, required: false
  delegate :zone, to: :post
  delegate :municipality, to: :zone
  delegate :department, to: :municipality
  has_many :reset_tokens
  has_many :tables
end
