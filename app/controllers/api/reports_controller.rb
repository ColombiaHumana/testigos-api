# frozen_string_literal: true

module Api
  # Report table controller
  class ReportsController < Api::ApiController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    def create
      @report = current_user.tables.find(params[:report][:table_id]).reports.where(issue: params[:report][:issue_id], user: current_user).first_or_create
      raise ActiveRecord::RecordNotFound unless @report
      render status: :created
    end

    private
    def table
      params.require(:report).permit(:table_id)
    end

    def type
      params.require(:report).permit(:issue_id)
    end

    def record_not_found
      head 404
    end
  end
end
