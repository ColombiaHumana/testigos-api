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
  has_one :puesto, foreign_key: :coordinator_id, class_name: 'Post'
  before_save :check_coordinator
  def to_s
    self.name
  end

  def self.from_token_request(request)
    username = request.params["auth"] && request.params['auth']['document']
    self.find_by document: username
  end

  private

  def check_coordinator
    if self.coordinator?
      Post.find(self.post.id).update coordinator: self
    end
  end
end
