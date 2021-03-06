# frozen_string_literal: true

# Controller for panel
class PanelController < ApplicationController
  before_action :authenticate_panel_user!, only: %i[index escrutado new create edit update proyeccion]
  before_action :compute_data, only: %i[muestreo proyeccion departamentos mapa_muestreo]
  before_action :res, only: :resultados
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
  end

  def muestreo; end

  def resultados; end

  def mapa
    @departments = Department.where(id: 1..33)
  end

  def mapa_muestreo; end
  
  def departamentos
    @departments = computed_departments
  end

  def testigos
    users = User.where(enabled: true, uploaded: true)
    @total = users.count
    @reported = users.joins(:rounds).count
    @reported_percent = (@reported * 100.0 / @total).round(2)
    @logged = users.where(online: true).count
    @logged_percent = (@logged * 100.0 / @total).round(2)
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

  def computed_departments
    @candidatos.each.collect do |candidato|
      departments = Department.where(id: 1..33).orden.collect do |department|
        department.rounds.public_send("total_#{candidato.first}")
      end
      {
        name: candidato.last,
        data: departments
      }
    end
  end

  def res
    @candidatos = CANDIDATOS
    petro = Round.total_petro
    duque = Round.total_duque
    blancos = Round.total_blancos
    no_marcados = Round.total_no_marcados
    nulos = Round.total_nulos
    total = petro + duque + blancos + no_marcados + nulos
    @totales_validas = {
      petro: petro,
      duque: duque,
      blancos: blancos,
      no_marcados: no_marcados,
      nulos: nulos,
      total_validos: Round.total_validos,
      total: total
    }
  end

  def compute_data
    @candidatos = CANDIDATOS
    @computed = Department.where(id: 1..33).order(name: :asc).collect do |department|
      resultados = department.rounds.muestreo
      total = resultados.total_validos
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
      nulos = resultados.total_nulos
      nulos_ponderado = nulos * department.coefficient
      no_marcados = resultados.total_no_marcados
      no_marcados_ponderado = no_marcados * department.coefficient
      total_ponderado = petro_ponderado + duque_ponderado + blanco_ponderado
      total_ponderado_s = total_ponderado + nulos_ponderado + nulos_ponderado
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
        total_ponderado: total_ponderado.nan? ? 0 : total_ponderado,
        total_ponderado_s: total_ponderado_s.nan? ? 0 : total_ponderado_s,
        nulos: nulos,
        nulos_ponderado: nulos_ponderado.nan? ? 0 : nulos_ponderado,
        no_marcados: no_marcados,
        no_marcados_ponderado: no_marcados_ponderado.nan? ? 0 : no_marcados_ponderado,
        escrutado: department.tables.muestreo.escrutado.count * 100.0 / department.tables.muestreo.count
      }
    end
    @totales = {
      petro: @computed.map { |s| s[:petro_ponderado] }.reduce(0, :+),
      duque: @computed.map { |s| s[:duque_ponderado] }.reduce(0, :+),
      blancos: @computed.map { |s| s[:blancos_ponderado] }.reduce(0, :+),
      no_marcados: @computed.map { |s| s[:no_marcados_ponderado] }.reduce(0, :+),
      nulos: @computed.map { |s| s[:nulos_ponderado] }.reduce(0, :+),
      total: @computed.map { |s| s[:total_ponderado] }.reduce(0, :+),
      total_s: @computed.map { |s| s[:total_ponderado_s] }.reduce(0, :+)
    }
    @totales_validas = {
      petro: @computed.map { |s| s[:petro] }.reduce(0, :+),
      duque: @computed.map { |s| s[:duque] }.reduce(0, :+),
      blancos: @computed.map { |s| s[:blancos] }.reduce(0, :+),
      no_marcados: @computed.map { |s| s[:no_marcados] }.reduce(0, :+),
      nulos: @computed.map { |s| s[:nulos] }.reduce(0, :+),
      total: @computed.map { |s| s[:total] }.reduce(0, :+)
    }
  end
end
