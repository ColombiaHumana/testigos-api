class Municipality < ApplicationRecord
  belongs_to :department
  has_many :zones
  has_many :posts, through: :zones
  has_many :tables, through: :posts
  has_many :users, through: :tables

  def to_s
    self.name
  end
end
