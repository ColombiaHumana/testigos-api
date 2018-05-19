# frozen_string_literal: true

module Api
  # Results controller
  class ResultsController < Api::ApiController
    def create
      table = current_user.tables.find(params[:result][:table_id])
      @result = table.result || table.create_result(user: current_user, votes: params[:result][:votes], image: params[:result][:image])
      raise ActiveRecord::RecordNotFound unless @result.valid?
      render status: :created
    end

    private

    def result_params
      params.require(:result).permit(:votes, :image)
    end
  end
end
