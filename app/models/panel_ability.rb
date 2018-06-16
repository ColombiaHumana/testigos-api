# frozen_string_literal: true

# Abilities for panel users
class PanelAbility
  include CanCan::Ability
  def initialize(user)
    user ||= PanelUser.new

    if user.role == :callcenter
      can :read, User
    end

    if user.role == "report"
      can :read, :proyeccion
    end
  end
end
