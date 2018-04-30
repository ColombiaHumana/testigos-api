class Issue < ApplicationRecord
  has_many :reports
  default_scope { order(created_at: :desc) }
end
