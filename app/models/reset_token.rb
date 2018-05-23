class ResetToken < ApplicationRecord
  belongs_to :user
  has_secure_token
  validates_uniqueness_of :token
  before_create :disable_last
  # after_commit :send_email

  def to_param
    token
  end

  private

  def disable_last
    self.user.reset_tokens.update_all used: true
  end

  # def send_email
  #   PasswordMailer.reset(self).deliver_later
  # end
end
