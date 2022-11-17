class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all

    return unless user.present? # logged in user permissions (read and delete their own POST and COMMENTS)

    can :read, :all
    can :manage, User, id: user.id
    can :manage, Post, author_id: user.id
    can :manage, Comment, author_id: user.id

    return unless user.role == 'admin' # admin permissions

    can :manage, :all
  end
end
