# frozen_string_literal: true

# Abilities for admin users
class AdminAbility
  include CanCan::Ability

  def initialize(user)
    can :read, ActiveAdmin::Page, name: 'Dashboard', namespace_name: 'admin'
    # if user.role? 'municipal'
    #   # can %i[read update], User, User.municipales(user) do |u|
    #   #   # u.municipality == user.municipality
    #   # end
    # end
    if user.role?('lector')
      can :read, Issue
      can :read, Report
      can :read, ActiveAdmin::Page,
          name: 'Resumen', namespace_name: 'admin'
      can :read, ActiveAdmin::Page, name: 'Incidencias', namespace_name: 'admin'
    end

    if user.role?('moderador')
      can :manage, News
      can %i[read update], User
      can :read, ActiveAdmin::Page,
          name: 'Proyecciones', namespace_name: 'admin'
      can :read, ActiveAdmin::Page, name: 'Mesas', namespace_name: 'admin'
      can :read, ActiveAdmin::Page, name: 'Escrutinio', namespace_name: 'admin'
      can :manage, Table
      can :manage, Report
    end

    can :manage, :all if user.role?('administrador')
  end
end
