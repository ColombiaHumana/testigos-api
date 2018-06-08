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
    mail to: @token.user.email, subject: 'Configura tu contraseña de testigo'
  end

  def verify(token)
    @token = token
    mail to: @token.user.email, subject: 'Verifica tu dirección de correo'
  end

  def validated(user, password)
    @user = user
    @password = password
    mail to: @user.email, subject: 'Esta es tu nueva contraseña'
  end

  def invitation(user)
    @user = user
    mail to: @user.email, subject: 'Defendamos el voto, fortalezcamos la democracia.'
  end
end
