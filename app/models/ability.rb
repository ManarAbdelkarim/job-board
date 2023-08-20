# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new  # guest user (not logged in)
    if user.admin?
      can :manage, JobPost
    end
    if user.admin
        admin_abilities(user)
    elsif user.id
        user_abilities(user)
    else
      can :create, User
    end
  end
  private

  def user_abilities(user)
      can [:show, :read], JobApplication, :user_id => user.id
      can [:create], JobApplication
      can [:show, :read], JobPost
      can [:show, :update], User, :id => user.id
  end

  def admin_abilities(user)
  can :manage, :all
  cannot :destroy, [JobApplication, User]
end
end
