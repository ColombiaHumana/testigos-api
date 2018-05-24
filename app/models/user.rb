class User < ApplicationRecord
  has_secure_password
  before_validation :clean_user
  before_validation :clean_email, unless: -> (user) { user.email.blank? }
  validates :document, presence: true, uniqueness: true
  validates :email, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i }, unless: -> (user) { user.email.blank? }
  belongs_to :post, required: false
  delegate :zone, to: :post
  delegate :municipality, to: :zone
  delegate :department, to: :municipality
  has_many :reset_tokens
  has_many :tables
  has_many :results
  has_many :validation_tokens
  has_one :puesto, foreign_key: :coordinator_id, class_name: 'Post'
  after_save :check_coordinator
  def to_s
    self.name
  end

  def self.from_token_request(request)
    username = request.params["auth"] && request.params['auth']['document']
    self.find_by document: username
  end

  private

  def clean_user
    self.name = self.name.titleize.strip
  end

  def clean_email
    self.email = self.email.downcase.strip
  end

  def check_coordinator
    if self.coordinator?
      Post.find(self.post.id).update coordinator: self
    end
  end
end
