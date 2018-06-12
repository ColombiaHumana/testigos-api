# frozen_string_literal: true

module Api
  # Controller for second round reports
  class RoundController < ApiController
    before_action :set_table, only: :create
    before_action :set_result, only: :create

    def create
      render status: :created if @result.id_previously_changed?
    end

    private

    def set_table
      @table = Table.find(table_params[:table_id])
    end

    def set_result
      @result = @table.round || Round.create(round_params)
    end

    def table_params
      params.require(:round).permit(:table_id)
    end

    def round_params
      params.require(:round).permit(
        :table_id,
        :image,
        votes: %i[
          petro
          duque
          blanco
          nulos
          no_marcados
          total_e11
          total_urna
          total_incinerados
          total_validos
        ]
      ).merge(user_id: current_user.id)
    end
  end
end
