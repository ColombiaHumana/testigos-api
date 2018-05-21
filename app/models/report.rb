class Report < ApplicationRecord
  belongs_to :issue
  belongs_to :user
  belongs_to :table
  delegate :post, to: :table
  delegate :zone, to: :table
  delegate :municipality, to: :table
  delegate :department, to: :table
end
