class Post < ApplicationRecord
  belongs_to :zone
  has_many :tables
  has_many :users
  has_many :results, through: :tables
  belongs_to :coordinator, class_name: 'User'
  delegate :municipality, to: :zone
  delegate :department, to: :municipality

  def to_s
    self.name
  end
end
