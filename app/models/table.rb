class Table < ApplicationRecord
  belongs_to :post
  belongs_to :user, required: false
  has_many :reports
  has_one :result
  delegate :zone, to: :post
  delegate :municipality, to: :zone
  delegate :department, to: :municipality
  default_scope { order(order: :asc).where(sample: true) }

  def to_s
    "Mesa #{self.cod_table}"
  end
end
