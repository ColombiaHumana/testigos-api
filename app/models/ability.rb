class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
    can :read, :all
    if user.coordinator?
      can :update, User
    end

    if user.online?
      can :create, Report, table: { id: user.table_ids }
      can :create, Result, table: { id: user.table_ids }
    end

  end
end
