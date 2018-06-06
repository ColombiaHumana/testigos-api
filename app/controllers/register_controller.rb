# frozen_string_literal: true

class RegisterController < ApplicationController
  def new
    @user = User.new
  end

  def iframe
    @user = User.new
    render :new, layout: 'iframe'
  end

  def create
    @user = User.new(user_params)
    if @user.save
      RegisterMailer.create(@user.id).deliver_later
    else
      render :new
    end
  end

  def show
    @token = Token.find_by(token: params[:token])
    @token.update! used: true
  end

  def get_department
    @departments = Department.where(id: 1..33).order(name: 'asc')
  end

  def get_municipality
    @municipalities = Department.find(params[:department_id]).municipalities.order(name: 'asc')
  end

  def get_zone
    @zones = Municipality.find(params[:municipality_id]).zones.order(cod_zone: 'asc')
  end

  def get_post
    @posts = Zone.find(params[:zone_id]).posts.order(name: 'asc')
  end

  private

  def user_params
    password = User.gen_password
    params.require(:user).permit(:first_name, :second_name, :surname, :second_surname, :document, :post_id, :email, :phone).merge(password: password, password_confirmation: password)
  end

  def municipality_params
    params.require(:user).permit(:department_id)
  end

  def zone_params
    params.require(:user).permit(:municipality_id)
  end

  def post_params
    params.require(:user).permit(:zone_id)
  end
end
