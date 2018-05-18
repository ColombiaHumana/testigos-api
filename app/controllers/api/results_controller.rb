# frozen_string_literal: true

module Api
  # Results controller
  class ResultsController < Api::ApiController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    def create
    @result = current_user.tables.find(params[:result][:table_id]).create_result user: current_user, votes: params[:result][:votes], image: params[:result][:image]
      raise ActiveRecord::RecordNotFound unless @result.valid?
      render status: :created
    end

    private

    def result_params
      params.require(:result).permit(:votes, :image)
    end

    def record_not_found
      head 404
    end
  end
end
