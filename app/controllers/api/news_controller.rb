class Api::NewsController < ApplicationController
  before_action :autenticate_user
  respond_to :json

  def index
    
  end
end
