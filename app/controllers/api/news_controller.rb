# frozen_string_literal: true

module Api
  # News view controller
  class NewsController < Api::ApiController
    # Define POST method to receive News /api/news
    def index
      @news = News.where(public: true).last(5)
    end
  end
end
