# frozen_string_literal: true

module Api
  # Push notifications controller
  class PushController < Api::ApiController
    def register
      current_user.update(push_params)
    end

    private

    def push_params
      params.require(:token).permit(:push_token)
    end
  end
end
