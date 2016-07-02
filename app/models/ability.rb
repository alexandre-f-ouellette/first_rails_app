class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :manage, User, id: user.id
    can :manage, Order, user_id: user.id

    if user.admin?
      can :manage, Comment
      can :manage, Product
    else
      can :read, Comment
      can :create, Comment
      can :destroy, Comment, user_id: user.id

      can :read, Product
      cannot [:create, :update, :destroy], Product
    end
  end
end
