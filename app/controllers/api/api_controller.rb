# frozen_string_literal: true

module Api
  # Default class for api authenticated endpoints
  class ApiController < ApplicationController
    include Knock::Authenticable
    before_action :authenticate_user
    protect_from_forgery with: :null_session
  end
end
