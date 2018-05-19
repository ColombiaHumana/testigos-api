# frozen_string_literal: true

module Api
  # Default class for api authenticated endpoints
  class ApiController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    include Knock::Authenticable
    before_action :authenticate_user
    protect_from_forgery with: :null_session

    def record_not_found
      head 404
    end
  end
end
