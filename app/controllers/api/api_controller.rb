class Api::ApiController < ApplicationController
  include Knock::Authenticable
  before_action :authenticate_user
  protect_from_forgery with: :null_session
  respond_to :json
end
