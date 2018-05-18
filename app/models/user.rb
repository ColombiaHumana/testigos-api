class User < ApplicationRecord
  has_secure_password
  validate :document, presence: true, uniqueness: true
  belongs_to :post, required: false
  delegate :zone, to: :post
  delegate :municipality, to: :zone
  delegate :department, to: :municipality
  has_many :reset_tokens
  has_many :tables
  has_many :results

  def to_s
    self.name
  end
end
