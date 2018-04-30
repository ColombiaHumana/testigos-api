class Result < ApplicationRecord
  belongs_to :table
  belongs_to :user, required: :false
end
