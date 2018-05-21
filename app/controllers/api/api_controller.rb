# frozen_string_literal: true

module Api
  # Default class for api authenticated endpoints
  class ApiController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from CanCan::AccessDenied, with: :unauthorized
    include Knock::Authenticable
    before_action :authenticate_user
    protect_from_forgery with: :null_session
    load_and_authorize_resource
    check_authorization

    def record_not_found
      head 404
    end

    def unauthorized
      head 401
    end
  end
end
