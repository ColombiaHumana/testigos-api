class Post < ApplicationRecord
  belongs_to :zone
  has_many :tables
  has_many :users, through: :tables
  delegate :municipality, to: :zone
  delegate :department, to: :municipality

  def to_s
    self.name
  end
end
