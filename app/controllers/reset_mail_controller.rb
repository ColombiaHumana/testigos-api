# frozen_string_literal: true

# Reset email controller frontend
class ResetMailController < ApplicationController
  before_action :set_reset_mail, only: %i[show update]

  def show
    raise ActionController::RoutingError, 'Not Found' if @reset_mail.used?
  end

  def update
    password = rand(36**8).to_s(36)
    @reset_email.user.update password: password, password_confirmation: password
    @reset_email.update used: true
    PasswordMailer.password(@reset_email.user, password).deliver_later
  end

  private

  def set_reset_mail
    @reset_mail = ResetToken.find_by(token_params)
  end

  def token_params
    params.require(:reset_token).permit(:token)
  end
end
