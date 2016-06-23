class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :manage, User, id: user.id
    can :manage, Order, user_id: user.id

    if user.admin?
      can :delete, Comment
    else
      can :read, Comment
    end
  end
end
