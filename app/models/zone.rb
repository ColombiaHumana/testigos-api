class Zone < ApplicationRecord
  belongs_to :municipality
  has_many :posts
  has_many :tables, through: :posts
  has_many :users, through: :tables
  delegate :department, to: :municipaly
end
