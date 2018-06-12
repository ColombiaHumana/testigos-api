# frozen_string_literal: true

# Controller to display available tables

module Api
  class TablesController < ApiController
    def show
      @tables = current_user.post.tables.where(user: nil).orden
    end
  end
end
