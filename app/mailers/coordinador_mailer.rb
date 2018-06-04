class CoordinadorMailer < ApplicationMailer

  def create(coordinador_id)
    @coordinador = User.find(coordinador_id)
    @password = User.gen_password
    Coordinador.create! email: @coordinador.email, password: @password, password_confirmation: @password, user: @coordinador
    mail to: @coordinador.email, subject: 'Haz sido validado como coordinador de puesto'
  end

end
