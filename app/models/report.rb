class Report < ApplicationRecord
  belongs_to :issue
  belongs_to :user
  belongs_to :table
  delegate :post, to: :table
  delegate :zone, to: :post
  delegate :municipality, to: :zone
  delegate :department, to: :municipality
end
