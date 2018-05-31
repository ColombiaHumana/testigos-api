class RegisterMailer < ApplicationMailer
  def create(user_id)
    @token = ResetToken.create! user: User.find(user_id)
    mail to: @token.user.email, subject: 'Registro exitoso, verifica tu correo y configura una contraseña'
  end

end
