# frozen_string_literal: true

# Controller for panel
class PanelController < ApplicationController
  before_action :authenticate_panel_user!
  before_action :set_table, except: %i[index escrutado]
  before_action :set_round, only: %i[new edit create update]
  layout 'panel'

  CANDIDATOS = [
    ['petro', 'Gustavo Petro'],
    ['duque', 'Ivan Duque'],
    ['blancos', 'Voto Blanco']
  ]

  def index
    @tables = Table.muestreo.pendiente.orden_muestreo.page params[:page]
  end

  def escrutado
    @tables = Table.muestreo.escrutado.orden_muestreo.page params[:page]
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
    @candidatos = CANDIDATOS
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
