class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    # A user can manage their own events and themself
    unless user.new_record?
      can :manage, Event, :user_id => user.id
      can :manage, User, :user_id => user.id
    end
    
    
    if user.admin?
      can :manage, :all
    elsif !user.new_record?
      can :create, Comment
      can :create, Event
      can :create, Friendship
      can :create, Attendance
      can :create, City
      can :create, Tag
      can :read, :all
    else
      can :read, :all
    end
  end
end
