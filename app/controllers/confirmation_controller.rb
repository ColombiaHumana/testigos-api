# frozen_string_literal: true

# Confirmation controller for acceptance of witnesses
class ConfirmationController < ApplicationController
  before_action :set_user,
                only: %i[
                  accept
                  coordinator
                  edit
                  reject
                  thanks
                  update
                  update_coordinator
                ]

  def accept
    @user.update! confirmation: :aceptada
    redirect_to :confirmation_thanks
  end

  def coordinator; end

  def edit; end

  def reject
    @user.update! confirmation: :rechazada
  end

  def thanks; end

  def thanks_coordinator; end

  def update
    if @user.update_attributes(user_params.merge(confirmation: :aceptada))
      redirect_to :confirmation_thanks
    else
      redirect_to :edit
    end
  end

  def update_coordinator
    if @user.update_attributes(coordinator_params)
      redirect_to :confirmation_thanks_coordinator
    else
      redirect_to :thanks
    end
  end

  private

  def set_user
    @user = User.find_by(token: params[:token])
  end

  def user_params
    params.require(:user).permit(
      :post_id
    )
  end

  def coordinator_params
    params.require(:user).permit(
      :gestion
    ).merge confirmation: :coordinador
  end
end
