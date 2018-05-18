class User < ApplicationRecord
  has_secure_password
  validates :document, presence: true, uniqueness: true
  belongs_to :post, required: false
  delegate :zone, to: :post
  delegate :municipality, to: :zone
  delegate :department, to: :municipality
  has_many :reset_tokens
  has_many :tables
  has_many :results

  def to_s
    self.name
  end

  def self.from_token_request(request)
    username = request.params["auth"] && request.params['auth']['document']
    self.find_by document: username
  end
end
