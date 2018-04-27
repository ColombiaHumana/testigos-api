# frozen_string_literal: true

module Api
  # GET user details
  class UserController < Api::ApiController
    # GET user details /api/user
    def show
      @user = current_user
    end
  end
end
