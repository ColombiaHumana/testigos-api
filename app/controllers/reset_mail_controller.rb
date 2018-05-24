# frozen_string_literal: true

# Reset email controller frontend
class ResetMailController < ApplicationController
  before_action :set_reset_mail, only: %i[show update validation]

  def show
    raise ActionController::RoutingError, 'Not Found' if @reset_mail.used?
  end

  def update
    raise ActionController::RoutingError, 'Not Found' if @reset_mail.used?
    password = sprintf('%05d', rand(10**5))
    @reset_mail.user.update password: password, password_confirmation: password, verified_email: true
    @reset_mail.update used: true
    PasswordMailer.password(@reset_mail.user, password).deliver_later(queue: 'resets')
  end

  def validation
    raise ActionController::RoutingError, 'Not Found' if @reset_mail.used?
    @reset_mail.user.update! verified_email: true
    @reset_mail.update used: true
    PasswordMailer.validated(@reset_mail.user).deliver_later
  end

  private

  def set_reset_mail
    @reset_mail = ResetToken.find_by(token_params)
  end

  def token_params
    params.permit(:token)
  end
end
