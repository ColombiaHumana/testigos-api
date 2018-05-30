class RegisterMailer < ApplicationMailer
  def create(user_id)
    @token = Token.create! user: User.find(user_id)
    mail to: @token.user.email, subject: 'Registrado como testigo, verifica tu correo y configura una contraseña'
  end

end
