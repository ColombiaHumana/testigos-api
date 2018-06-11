# frozen_string_literal: true

# Generate JWT for user
class UserTokenController < Knock::AuthTokenController
  protect_from_forgery with: :null_session

  private

  def auth_params
    params.require(:auth).permit :document, :password
  end
end
