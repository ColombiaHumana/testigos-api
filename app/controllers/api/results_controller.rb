# frozen_string_literal: true

module Api
  # Results controller
  class ResultsController < Api::ApiController
    before_action :find_or_create_result
    def create
      head :unprocessable_entity unless @result.valid?
      if @result.valid?
        @result.id_previously_changed? ? (render status: :created) : (render status: :ok)
      end
    end

    private

    def find_or_create_result
      @result = Result.find_by(table_id: result_params[:table_id]) || Result.create(result_params)
    end

    def result_params
      params.require(:result).permit(:table_id, :image, votes: %i[
        total_mesa
        petro
        promotores
        duque
        la_calle
        trujillo
        fajardo
        morales
        vargas
        votos_validos
        votos_blancos
        votos_nulos
        votos_no_marcados
        total
      ]).merge(user_id: current_user.id)
    end
  end
end
