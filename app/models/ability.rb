# frozen_string_literal: true

# Abilities for users
class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)

    can :read, User, id: user.id
    can :read, Table
    can :read, News
    can :email, User, id: user.id

#     if user.coordinator?
#       can :update, User, post: { id: user.puesto.id }
#     end

    # if user.online?
    can :create, Report, table: { id: user.post.table_ids }
    can :create, Result, table: { id: user.post.table_ids }
    can :create, Round, table: { id: user.post.table_ids }
    # end
  end
end
