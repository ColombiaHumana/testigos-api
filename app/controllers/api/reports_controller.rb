# frozen_string_literal: true

module Api
  # Report table controller
  class ReportsController < Api::ApiController
    before_action :find_or_create_report, only: :create

    def create
      head :unprocessable_entity unless @report.valid?
      if @report.valid?
        @report.id_previously_changed? ? (render status: :created) : (render status: :ok)
      end
    end

    private

    def find_or_create_report
      @report = Report.where(report_params).first_or_create
    end

    def report_params
      params.require(:report).permit(:issue_id, :table_id).merge(user_id: current_user.id)
    end
  end
end
