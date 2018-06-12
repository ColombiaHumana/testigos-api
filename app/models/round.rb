# frozen_string_literal: true

# Second round votes model
class Round < ApplicationRecord
  after_commit :send_to_secure_vote
  belongs_to :table
  belongs_to :user

  ROUND_JSON_SCHEMA = Rails.root.join(
    'config',
    'schemas',
    'round.json_schema'
  ).to_s

  validates :votes, presence: true, json: { schema: ROUND_JSON_SCHEMA }

  store_accessor :votes,
                 :petro,
                 :duque,
                 :blanco,
                 :nulos,
                 :no_marcados,
                 :total_e11,
                 :total_urna,
                 :total_incinerados,
                 :total_mesa,
                 :total_validos


  private

  def send_to_secure_vote
  end
end
