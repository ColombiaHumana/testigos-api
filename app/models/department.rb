class Department < ApplicationRecord
  has_many :municipalities
  has_many :zones, through: :municipalities
  has_many :posts, through: :zones
end
