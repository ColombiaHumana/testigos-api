class ValidateController < ApplicationController
  before_action :authenticate_coordinador!
  layout 'app'
  def index; end

  def show
    @user = current_coordinador.user.post.users.where(
      enabled: false,
      rejected: false,
    ).where.not(phone: nil).sample
    if @user
      redirect_to edit_user_path(@user)
    else
      flash[:notice] = 'Todos los testigos disponibles para este puesto han sido verificados, si requieres de más testigos, pide a conocidos y amigos llenar el formulario para tú puesto.'
      redirect_to root_path
    end
  end

  def edit_user
    @user = User.find_by!(token: params[:token], post: current_coordinador.user.post)
    @user.validate_user = true
  end

  def help; end

  def update_user
    @user = User.find_by!(token: params[:token], post: current_coordinador.user.post)
    @user.validate_user = true
    if @user.update_attributes(user_params)
      flash[:notice] = "El testigo #{@user.name} ha sido validado exitosamente!"
      CoordinadorMailer.validate(@user.id).deliver_later
      redirect_to root_path
    else
      flash[:alert] = 'Error en el formulario, por favor completa todos los campos requeridos'
      render :edit_user
    end
  end

  def reject_user
    @user = User.find_by!(token: params[:token], post: current_coordinador.user.post)
    @user.validate_user = false
    if @user.update_attributes(rejected: true)
      flash[:notice] = "El testigo #{@user.name} ha sido descartado exitosamente!"
      redirect_to root_path
    else
      flash[:alert] = 'Error en el formulario, por favor completa todos los campos requeridos'
      render :edit_user
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :table_ids
    ).merge(enabled: true)
  end
end
