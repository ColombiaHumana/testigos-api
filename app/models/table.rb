class Table < ApplicationRecord
  belongs_to :post
  belongs_to :user, required: false
  has_many :reports
  has_one :result
  has_one :round
  delegate :zone, to: :post
  delegate :municipality, to: :zone
  delegate :department, to: :municipality

  scope :orden, -> { order(cod_table: 'asc') }
  scope :muestreo, -> { where(sample: true) }
  def to_s
    "Mesa #{cod_table}"
  end

  def name
    "Mesa #{cod_table}"
  end
end
