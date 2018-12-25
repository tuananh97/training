class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    if user.supervisor?
      can :manage, :all
    else
      can :read, User, id: user.id
      can :update, User, id: user.id
    end
  end
end
