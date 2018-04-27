class Table < ApplicationRecord
  belongs_to :post
  belongs_to :user, required: false
  delegate :zone, to: :post
  delegate :municipality, to: :zone
  delegate :department, to: :municipality
end
