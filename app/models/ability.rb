class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    # A user can manage their own events
    can :manage, Event, :user_id => user.id
    
    if user.admin?
      can :manage, :all
    else
      can :read, :all
    end
  end
end
