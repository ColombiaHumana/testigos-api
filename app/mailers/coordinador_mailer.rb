# frozen_string_literal: true

# Mailer for coordinators
class CoordinadorMailer < ApplicationMailer
  def create(coordinador_id)
    @coordinador = User.find(coordinador_id)
    @password = User.gen_strong_password
    coordinador = Coordinador.find_by(email: @coordinador.email)

    Coordinador.create!(
      email: @coordinador.email,
      password: @password,
      password_confirmation: @password,
      user: @coordinador
    ) unless coordinador

    coordinador&.update password: @password,
                        password_confirmation: @password
    mail to: @coordinador.email,
         subject: 'Has sido validado como coordinador de puesto'
  end

  def validate(testigo_id)
    @testigo = User.find(testigo_id)
    mail to: @testigo.email, subject: 'Has sido validado como testigo'
  end

end
