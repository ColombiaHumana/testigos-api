# frozen_string_literal: true

# PasswordMailer
class PasswordMailer < ApplicationMailer
  def reset(token)
    @token = token
    mail to: token.user.email, subject: 'Reconfigurar contraseña'
  end

  def password(user)
    @user = user
    mail to: user.email, subject: 'Nueva contraseña'
  end
end
