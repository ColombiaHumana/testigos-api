class Department < ApplicationRecord
  has_many :municipalities
  has_many :zones, through: :municipalities
end
