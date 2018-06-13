# frozen_string_literal: true

# Post model
class Post < ApplicationRecord
  belongs_to :coordinator, class_name: 'User', required: false
  belongs_to :zone
  delegate :department, to: :municipality
  delegate :municipality, to: :zone
  has_many :results, through: :tables
  has_many :rounds, through: :tables
  has_many :tables
  has_many :users

  def to_s
    name
  end
end
