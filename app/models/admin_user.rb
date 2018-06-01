class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :role, presence: true

  ROLES = %w[validador lector moderador administrador]


  def role?(base_role)
    return false unless role
    ROLES.index(base_role.to_s) <= ROLES.index(role)
  end
end
