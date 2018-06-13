class ConfirmationMailer < ApplicationMailer
  def create(user_id)
    @user = User.find(user_id)
    mail to: @user.email, subject: 'Confirma tu asistencia como testigo'
  end

  def last_chance(user_id)
    @user = User.find(user_id)
    mail to: @user.email, subject: 'Ultima oportunidad para ser testigo'
  end
end
