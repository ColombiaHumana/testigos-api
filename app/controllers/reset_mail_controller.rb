class ResetMailController < ApplicationController
  before_action :set_reset_mail, only: [:show, :update]

  def show

  end

  def update
    
  end

  private
  def set_witness
    @reset_mail = ResetToken.find_by(token: params[:token])
  end
end
