# frozen_string_literal: true

# Controller for panel
class PanelController < ApplicationController
  layout 'app'
  def index
    @round = Table.find(236).build_round
  end
end
