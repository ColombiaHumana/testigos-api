class ConfirmationMailer < ApplicationMailer
  def create(user_id)
    @user = User.find(user_id)
    mail to: @user.email, subject: 'Confirma tu asistencia como testigo'
  end
end
