class Zone < ApplicationRecord
  belongs_to :municipality
  has_many :posts
  has_many :tables, through: :posts
  has_many :users, through: :tables
  has_many :reports, through: :tables
  has_many :results, through: :tables
  delegate :department, to: :municipaly

  def to_s
    "#{self.cod_zone}"
  end
end
