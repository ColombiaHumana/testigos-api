class ResetToken < ApplicationRecord
  belongs_to :user
  has_secure_token
  validates_uniqueness_of :token
end
