# frozen_string_literal: true

module Api
  # Default class for api authenticated endpoints
  class ApiController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :invalid_record
    rescue_from CanCan::AccessDenied, with: :unauthorized
    include Knock::Authenticable
    before_action :authenticate_user
    protect_from_forgery with: :null_session
    load_and_authorize_resource
    check_authorization

    def record_not_found
      head :not_found
    end

    def unauthorized
      head :unauthorized
    end

    def invalid_record
      head :bad_request
    end
  end
end
