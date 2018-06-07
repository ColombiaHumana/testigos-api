# frozen_string_literal: true

# Callcenter controller
class CallcenterController < ApplicationController
  before_action :authenticate_callcenter_user!
  before_action :set_user, only: %i[update_user reject_user edit_user]
  layout 'app'
  def index; end

  def show
    @user = User.validating.where.not(phone: nil).sample
    if @user
      redirect_to edit_user_path(@user)
    else
      flash[:notice] = 'Todos los coordinadores disponibles '\
        'han sido verificados.'
      redirect_to root_path
    end
  end

  def edit_user; end

  def help; end

  def update_user
    if @user.update_attributes(user_params)
      flash[:notice] = "El coordinador #{@user.name}"\
        'ha sido validado exitosamente!'
      CoordinadorMailer.create(@user.id).deliver_later
      redirect_to root_path
    else
      flash[:alert] = 'Error en el formulario, por favor'\
        'completa todos los campos requeridos'
      render :edit_user
    end
  end

  def reject_user
    if @user.update_attributes(rejected: true)
      flash[:notice] = "El coordinador #{@user.name}"\
        ' ha sido descartado exitosamente!'
      redirect_to root_path
    else
      flash[:alert] = 'Error en el formulario, por favor '\
        'completa todos los campos requeridos'
      render :edit_user
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :email
    ).merge(enabled: true)
  end

  def set_user
    @user = User.find_by(
      token: params[:token],
      coordinator: true
    )
    @user.validate_user = false
  end
end
