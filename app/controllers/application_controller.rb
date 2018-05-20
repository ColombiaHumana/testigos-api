# frozen_string_literal: true

# Base application controller
class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  def index
    render json: params
  end
end
