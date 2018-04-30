class AdminAbility
  include CanCan::Ability

  def initialize(user)
    can :read, ActiveAdmin::Page, name: "Dashboard", namespace_name: "admin"
    if user.role?('lector')
      can :read, ActiveAdmin::Page, name: "Dashboard", namespace_name: "admin"
      can :read, User
      can :read, News
      can :read, Issue
    end

    if user.role?('moderador')
      can :manage, News
    end

    if user.role?('administrador')
      can :manage, :all
    end

  end
end
