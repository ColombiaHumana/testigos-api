# frozen_string_literal: true

module Api
  # GET user details
  class UserController < Api::ApiController
    # GET user details /api/user
    def show
      @user = current_user
    end

    def update
      @user = current_user.post.users.find_by(user_params)
      raise ActiveRecord::RecordNotFound unless @user
      @user.update(online: true) if current_user.coordinator?
      render status: :created
    end

    private

    def user_params
      params.require(:user).permit :id
    end
  end
end
