# frozen_string_literal: true

# Second round votes model
class Round < ApplicationRecord
  after_commit :send_to_secure_vote
  after_commit :calculate_coefficient
  belongs_to :table
  belongs_to :user

  ROUND_JSON_SCHEMA = Rails.root.join(
    'config',
    'schemas',
    'round.json_schema'
  ).to_s

  validates :votes, presence: true, json: { schema: ROUND_JSON_SCHEMA }
  validates :image, presence: true

  scope :total_blancos, -> { sum("(votes ->> 'blanco')::int") }
  scope :total_duque, -> { sum("(votes ->> 'duque')::int") }
  scope :total_nulos, -> { sum("(votes ->> 'nulos')::int") }
  scope :total_petro, -> { sum("(votes ->> 'petro')::int") }
  scope :total_validos, -> { sum("(votes ->> 'total_validos')::int") }
  scope :muestreo, -> { joins(:table).where('tables.sample = true') }
  scope :total_votos, -> { sum("(votes ->> 'total_mesa')::int") }

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
  attr_reader :total_check

  private

  # TODO: send data to securevote
  def send_to_secure_vote; end

  def calculate_coefficient
    scrutinized = self.table.department.scrutinized + self.total_mesa
    self.table.department.update scrutinized: scrutinized
    total_scrutinized = Department.sum(:scrutinized)
    Department.all.each do | d |
      percentage = (d.scrutinized / total_scrutinized.to_f)
      coefficient = (d.weight / percentage)
      d.update! percentage: percentage, coefficient: coefficient
    end
  end
end
