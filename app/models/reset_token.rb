class ResetToken < ApplicationRecord
  belongs_to :user
  has_secure_token
  validates_uniqueness_of :token
  before_create :disable_last

  def to_param
    token
  end
  
  private

  def disable_last
    self.user.reset_tokens.update_all used: true
  end
end
