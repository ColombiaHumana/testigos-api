class Table < ApplicationRecord
  belongs_to :post
  belongs_to :user, required: false
  has_many :reports
  has_many :results
  delegate :zone, to: :post
  delegate :municipality, to: :zone
  delegate :department, to: :municipality

  def to_s
    "Mesa #{self.cod_table}"
  end
end
