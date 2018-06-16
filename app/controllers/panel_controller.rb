# frozen_string_literal: true

# Controller for panel
class PanelController < ApplicationController
  before_action :authenticate_panel_user!
  before_action :set_table, except: %i[index escrutado]
  before_action :set_round, only: %i[new edit create update]
  layout 'panel'

  alias_method :current_user, :current_panel_user

  CANDIDATOS = [
    ['petro', 'Gustavo Petro'],
    ['duque', 'Ivan Duque'],
    ['blancos', 'Voto blancos']
  ]

  def current_ability
    @current_ability ||= PanelAbility.new(current_user)
  end

  def index
    @tables = Table.muestreo.pendiente.orden_muestreo.page(params[:page]).per(100)
  end

  def escrutado
    @tables = Table.muestreo.escrutado.orden_muestreo.page(params[:page]).per(100)
  end

  def new; end

  def create
    if @table.create_round!(round_params)
      flash[:notice] = "Mesa de muestreo #{@table.order} guardada correctamente"
      redirect_to :escrutadas
    else
      flash[:alert] = 'Error en los campos, por favor verifique'
      render :new
    end
  end

  def edit; end

  def update
    if @table.round.update(round_params)
      flash[:notice] = "Mesa de muestreo #{@table.order} editada correctamente"
      redirect_to :escrutadas
    else
      flash[:alert] = 'Error en los campos, por favor verifique'
      render :edit
    end
  end

  def proyeccion
    authorize! :read, :proyeccion
    @candidatos = CANDIDATOS
    @computed = Department.where(id: 1..33).order(name: :asc).collect do |department|
      resultados = department.rounds.muestreo
      total = resultados.total_validos
      total_ponderado = total * department.coefficient rescue 0
      petro = resultados.total_petro
      # porcentaje_petro = petro / total.nonzero? || 0
      petro_ponderado =  petro * department.coefficient rescue 0
      # porcentaje_petro_ponderado = petro_ponderado / total_ponderado
      duque = resultados.total_duque
      # porcentaje_duque = duque / total
      duque_ponderado =  duque * department.coefficient rescue 0
      # porcentaje_duque_ponderado = duque_ponderado / total_ponderado
      blancos = resultados.total_blancos
      # porcentaje_blanco = blancos / total
      blanco_ponderado = blancos * department.coefficient rescue 0
      # porcentaje_blanco_ponderado = blanco_ponderado / total_ponderado
      {
        department: department.name,
        petro: petro,
        # porcentaje_petro: porcentaje_petro,
        petro_ponderado: petro_ponderado.nan? ? 0 : petro_ponderado,
        # porcentaje_petro_ponderado: porcentaje_petro_ponderado,
        duque: duque,
        # porcentaje_duque: porcentaje_duque,
        duque_ponderado: duque_ponderado.nan? ? 0 : duque_ponderado,
        # porcentaje_duque_ponderado: porcentaje_duque_ponderado,
        blancos: blancos,
        # porcentaje_blanco: porcentaje_blanco,
        blancos_ponderado: blanco_ponderado.nan? ? 0 : blanco_ponderado,
        # porcentaje_blanco_ponderado: porcentaje_blanco_ponderado,
        total: total,
        total_ponderado: total_ponderado.nan? ? 0 : total_ponderado
      }
    end
    @totales = {
      petro: @computed.map { |s| s[:petro_ponderado] }.reduce(0, :+),
      duque: @computed.map { |s| s[:duque_ponderado] }.reduce(0, :+),
      blancos: @computed.map { |s| s[:blancos_ponderado] }.reduce(0, :+),
      total: @computed.map { |s| s[:total_ponderado] }.reduce(0, :+),
    }
  end

  private

  def set_round
    @round = @table.round || @table.build_round
  end

  def set_table
    @table = Table.find_by(order: params[:order])
  end

  def votes_params
    params.require(:round).permit(
      votes: %i[
        petro
        duque
        blanco
        nulos
        no_marcados
        total_e11
        total_urna
        total_incinerados
        total_mesa
        total_validos
      ]
    )
  end

  def round_params
    {
      votes: votes_params[:votes].transform_values(&:to_i),
      user_id: 31_448,
      image: 'http'
    }
  end


end
