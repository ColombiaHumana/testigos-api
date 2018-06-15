# frozen_string_literal: true

# Abilities for panel users
class PanelAbility
  include CanCan::Ability
  def initialize(user)
    user ||= PanelUser.new

    if user.role == :callcenter
      can :read, User
    end
  end
end
