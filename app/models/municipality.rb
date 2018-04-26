class Municipality < ApplicationRecord
  belongs_to :department
  has_many :zones
end
