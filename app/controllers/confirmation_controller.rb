# frozen_string_literal: true

# Confirmation controller for acceptance of witnesses
class ConfirmationController < ApplicationController
  before_action :set_user, only: %i[accept reject coordinator update]
  def accept
    @user.update! confirmation: :aceptada
  end

  def coordinator; end

  def update
    @user.update! user_params
  end

  def reject
    @user.update! confirmation: :rechazada
  end

  def thanks; end

  def thanks_coordinator; end

  private

  def set_user
    @user = User.find_by token: params[:token]
  end

  def user_params
    params.require(:user).permit(
      :post_id,
      :first_name,
      :second_name,
      :surname,
      :second_surname
    ).merge(confirmation: :coordinador)
  end
end
