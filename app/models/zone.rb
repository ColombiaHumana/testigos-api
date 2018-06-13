# frozen_string_literal: true

# Zone model
class Zone < ApplicationRecord
  belongs_to :municipality
  delegate :department, to: :municipality
  has_many :posts
  has_many :tables, through: :posts
  has_many :reports, through: :tables
  has_many :results, through: :tables
  has_many :rounds, through: :tables
  has_many :users, through: :tables

  def name
    "Zona #{cod_zone}"
  end
end
