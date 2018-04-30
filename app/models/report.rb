class Report < ApplicationRecord
  belongs_to :issue
  belongs_to :user
  belongs_to :table
end
