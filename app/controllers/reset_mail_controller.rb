# frozen_string_literal: true

# Reset email controller frontend
class ResetMailController < ApplicationController
  before_action :set_reset_mail, only: %i[show update validation]

  def show
    raise ActionController::RoutingError, 'Not Found' if @reset_mail.used?
  end

  def update
    unless @reset_mail.used?
      password = User.gen_password
      @reset_mail.user.update password: password, password_confirmation: password, verified_email: true
      @reset_mail.update used: true
      PasswordMailer.password(@reset_mail.user, password).deliver_later(queue: 'resets')
    end
  end

  def validation
    unless @reset_mail.used?
      password = User.gen_password
      @reset_mail.user.update password: password, password_confirmation: password, verified_email: true
      @reset_mail.update used: true
      PasswordMailer.validated(@reset_mail.user, password).deliver_later(queue: 'resets')
      ConfirmationMailer.create(@reset_mail.user.id).deliver_later
    end
  end

  private

  def set_reset_mail
    @reset_mail = ResetToken.find_by(token_params)
  end

  def token_params
    params.permit(:token)
  end
end
