# frozen_string_literal: true

module Api
  # GET user details
  class UserController < Api::ApiController
    before_action :set_user, only: %i{update}
    # GET user details /api/user
    def show
      @user = current_user
    end

    def update
      authorize! :update, @user
      @user.update(online: true)
      render status: :created
    end

    def email
      @user = current_user
      @user.update! email_params
      token = @user.reset_tokens.create!
      PasswordMailer.verify(token).deliver_later
      render 'show', status: :created
    end

    private

    def set_user
      @user = User.find_by(user_params)
    end

    def user_params
      params.require(:user).permit :id
    end

    def email_params
      params.require(:user).permit(:email).merge(verified_email: false)
    end
  end
end
