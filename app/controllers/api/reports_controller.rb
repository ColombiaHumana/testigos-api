# frozen_string_literal: true

module Api
  # Report table controller
  class ReportsController < Api::ApiController
    def create
      @report = current_user.tables.find(report_params['table_id']).reports.where(report_params).first_or_create
      raise ActiveRecord::RecordNotFound unless @report
      render status: :created
    end

    private

    def report_params
      params.require(:report).permit(:issue_id, :table_id).merge(user_id: current_user.id)
    end
  end
end
