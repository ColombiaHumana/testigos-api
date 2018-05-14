class Result < ApplicationRecord
  belongs_to :table
  belongs_to :user, required: :false

  VOTES_JSON_SCHEMA =  Rails.root.join('config', 'schemas', 'votes.json_schema').to_s

  validates :votes, presence: true, json: { schema: VOTES_JSON_SCHEMA }
end
