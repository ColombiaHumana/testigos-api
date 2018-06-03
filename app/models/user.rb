class User < ApplicationRecord
  has_secure_password
  before_validation :clean_user
  before_validation :clean_email, unless: -> (user) { user.email.blank? }
  validates :document, presence: true, uniqueness: true
  validates_numericality_of :document, greater_than_or_equal_to: 10000
  validates :phone, presence: true, format: { with: /\A3[0-9]{9}\z/ }
  validates :email, uniqueness: true, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i }
  validates_presence_of :first_name, :surname, on: :create
  belongs_to :post
  delegate :zone, to: :post, allow_nil: true
  delegate :municipality, to: :zone, allow_nil: true
  delegate :department, to: :municipality, allow_nil: true
  has_many :reset_tokens
  has_many :tables
  validates_presence_of :table_ids, :name, on: :update, if: -> (user) {user.validate_user?}
  has_many :results
  has_one :puesto, foreign_key: :coordinator_id, class_name: 'Post'
  after_save :check_coordinator
  attr_accessor :validate_user
  def to_s
    self.name
  end
  def self.from_token_request(request)
    username = request.params["auth"] && request.params['auth']['document']
    self.find_by document: username
  end

  def self.gen_password
    sprintf('%05d', rand(10**5))
  end

  def validate_user?
    self.validate_user == true
  end
  private



  def clean_user
    self.name = "#{self.first_name} #{self.second_name} #{self.surname} #{self.second_surname}".titleize unless self.first_name.nil?
    self.phone = self.phone.scan(/\d/).join('') unless self.phone.nil?
  end

  def clean_email
    self.email = self.email.downcase.strip.clean_up_typoed_email
  end

  def check_coordinator
    if self.coordinator?

      Coordinador.create email: self.email, password: password, password_confirmation: password
      Post.find(self.post.id).update coordinator: self
    end
  end
end
