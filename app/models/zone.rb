class Zone < ApplicationRecord
  belongs_to :municipaly
  has_many :posts
end
