class Api::PasswordController < ApplicationController


  # Generate ResetToken to user by email
  def create
    User.find_by(email: params[:email]).reset_tokens.create
  end

end
