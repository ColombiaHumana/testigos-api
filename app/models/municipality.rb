class Municipality < ApplicationRecord
  belongs_to :department
  has_many :zones
  has_many :posts, through: :zones
end
