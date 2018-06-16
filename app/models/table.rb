# frozen_string_literal: true

# Table model
class Table < ApplicationRecord
  belongs_to :post
  belongs_to :user, required: false
  delegate :department, to: :municipality
  delegate :municipality, to: :zone
  delegate :zone, to: :post
  has_many :reports
  has_one :result
  has_one :round

  scope :orden, -> { order(cod_table: 'asc') }
  scope :orden_muestreo, -> { order(order: 'asc') }
  scope :muestreo, -> { where(sample: true) }
  scope :escrutado, -> { joins(:round) }
  scope :validas, -> { where.not(cod_table: %w[901 902 903]) }
  scope :pendiente, -> { left_joins(:round).where('rounds.id IS null').validas }

  def to_s
    "Mesa #{cod_table}"
  end

  def name
    to_s
  end

  def to_param
    order.to_s
  end
end
