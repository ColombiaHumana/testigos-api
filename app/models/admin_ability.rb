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
      can :read, ActiveAdmin::Page, name: 'Muestreo', namespace_name: 'admin'
      can :manage, News
    end

    if user.role?('administrador')
      can :manage, :all
    end

  end
end
