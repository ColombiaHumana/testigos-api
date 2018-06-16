# frozen_string_literal: true

# Department model
class Department < ApplicationRecord
  has_many :municipalities
  has_many :posts, through: :zones
  has_many :tables, through: :posts
  has_many :reports, through: :tables
  has_many :results, through: :tables
  has_many :rounds, through: :tables
  has_many :users, through: :posts
  has_many :zones, through: :municipalities

  scope :escrutadas, -> { joins(:rounds).count }
  scope :orden, -> { order(name: :asc) }

  def to_s
    name
  end
end
