class Result < ApplicationRecord
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
    :piedad,
    :vargas,
    :votos_validos,
    :votos_blancos,
    :votos_nulos,
    :votos_no_marcados,
    :total
end
