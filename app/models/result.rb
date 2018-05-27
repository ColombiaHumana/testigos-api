class Result < ApplicationRecord
  after_commit :send_to_spek, on: :create
  after_commit :calculate_coefficient, on: %i{create update}, if: -> (result) { result.table.sample? }
  belongs_to :table
  belongs_to :user, required: :false

  VOTES_JSON_SCHEMA =  Rails.root.join('config', 'schemas', 'votes.json_schema').to_s

  validates :votes, presence: true, json: { schema: VOTES_JSON_SCHEMA }

  store_accessor :votes,
    :total_mesa,
    :petro,
    :promotores,
    :duque,
    :la_calle,
    :trujillo,
    :fajardo,
    :morales,
    :vargas,
    :votos_validos,
    :votos_blancos,
    :votos_nulos,
    :votos_no_marcados,
    :total

  private

  def send_to_spek
    SpekJob.perform_later(self)
  end

  def calculate_coefficient
    scrutinized = self.table.department.scrutinized + self.votos_validos
    self.table.department.update scrutinized: scrutinized
    total_scrutinized = Department.sum(:scrutinized)
    Department.all.each do | d |
      percentage = (d.scrutinized / total_scrutinized.to_f)
      coefficient = (d.weight / percentage)
      d.update! percentage: percentage, coefficient: coefficient
    end
  end
end

# Department.update_all percentage: 1, coefficient: 1, scrutinized: 0
# Result.destroy_all
