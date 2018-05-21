# frozen_string_literal: true

module Api
  # Results controller
  class ResultsController < Api::ApiController
    def create
      table = current_user.tables.find(params[:result][:table_id])
      @result = table.result || Result.create(result_params)
      raise ActiveRecord::RecordNotFound unless @result.valid?
      render status: :created
    end

    private

    def result_params
      params.require(:result).permit(:table_id, :votes, :image).merge(user_id: current_user.id)
    end
  end
end
