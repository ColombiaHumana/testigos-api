class UserTokenController < Knock::AuthTokenController
  protect_from_forgery with: :null_session
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  private
  def not_found
    render json: {error: "Usuario o contraseña inválida"}, status: :not_found
  end
end
