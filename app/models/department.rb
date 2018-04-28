class Department < ApplicationRecord
  has_many :municipalities
  has_many :zones, through: :municipalities
  has_many :posts, through: :zones
  has_many :tables, through: :posts
  has_many :users, through: :tables

  def to_s
    self.name
  end
end
