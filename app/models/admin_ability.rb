class AdminAbility
  include CanCan::Ability

  def initialize(user)
    can :read, ActiveAdmin::Page, name: "Dashboard", namespace_name: "admin"
    if user.role?('lector')
      can :read, User
      can :read, Issue
      can :read, Report
      can :read, ActiveAdmin::Page, name: 'Resumen', namespace_name: 'admin'
      can :read, ActiveAdmin::Page, name: 'Incidencias', namespace_name: 'admin'
    end

    if user.role?('moderador')
      can :read, ActiveAdmin::Page, name: 'Proyecciones', namespace_name: 'admin'
      can :read, ActiveAdmin::Page, name: 'Mesas', namespace_name: 'admin'
      can :manage, Table
      can :manage, Report
    end

    if user.role?('administrador')
      can :manage, :all
    end

  end
end
