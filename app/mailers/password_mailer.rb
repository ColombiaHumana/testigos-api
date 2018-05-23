# frozen_string_literal: true

# PasswordMailer
class PasswordMailer < ApplicationMailer
  def reset(token)
    @token = token
    mail to: token.user.email, subject: 'Reconfigurar contraseña'
  end

  def password(user, password)
    @user = user
    @password = password
    mail to: user.email, subject: 'Nueva contraseña'
  end

  def create(token)
    @token = token
    mail to: @token.user.email, subject: 'Simulacro de la aplicación de testigos'
  end
end
