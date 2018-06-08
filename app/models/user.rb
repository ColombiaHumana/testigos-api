# frozen_string_literal: true

# User model
class User < ApplicationRecord
  has_secure_password
  has_secure_token :token
  before_save :clean_name, unless: ->(user) { user.first_name.nil? }
  before_validation :clean_email
  before_validation :clean_phone
  belongs_to :post
  delegate :zone, to: :post, allow_nil: true
  delegate :municipality, to: :zone, allow_nil: true
  delegate :department, to: :municipality, allow_nil: true
  has_many :reset_tokens, dependent: :destroy
  has_many :tables
  validates_presence_of :first_name, :surname
  validates :document, presence: true, uniqueness: true
  validates :phone, presence: true, format: { with: /\A3[0-9]{9}\z/ }
  validates :email, uniqueness: true, presence: true, format: {
  with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  }
  validates_presence_of :table_ids,
                        :name,
                        on: :update,
                        if: ->(user) { user.validate_user? }
  has_many :results
  has_one :puesto, foreign_key: :coordinator_id, class_name: 'Post'
  after_save :check_coordinator
  attr_accessor :validate_user
  enum confirmation: %i[rechazada pendiente aceptada coordinador]
  scope :validating, lambda {
    where(coordinator: true, rejected: false, enabled: false)
  }
  scope :coordinators, -> { where(confirmation: :coordinador) }
  def to_s
    name
  end

  def to_param
    token
  end

  def self.from_token_request(request)
    username = request.params[:auth] && request.params[:auth][:document]
    find_by document: username
  end

  def self.gen_password
    format('%05d', rand(10**5))
  end

  def self.gen_strong_password
    (('0'..'9').to_a + ('a'..'z').to_a + ('A'..'Z').to_a).sample(8).join
  end

  def validate_user?
    validate_user == true
  end

  private

  def clean_name
    self.name = "#{first_name} #{second_name}"\
      "#{surname} #{second_surname}".titleize
  end

  def clean_phone
    self.phone = self.phone.scan(/\d/).join('')
  end

  def clean_email
    self.email = email.downcase.strip.clean_up_typoed_email
  end

  def check_coordinator
    Post.find(post.id).update coordinator: self if coordinator?
  end
end
