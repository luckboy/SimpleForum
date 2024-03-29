class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
    unless user.nil?
      if user.admin?
        can :read, :all
        can :manage, :all
        can :search, Topic
      else
        can :read, :all
        can :update, User, :id => user.id
        if user.mod?
          can(:manage, Topic) { |t| !t.by_admin? && (t.author == user || !t.by_mod?) }
          can(:manage, Post) { |p| !p.by_admin? && (p.author == user || !p.by_mod?) }
        else
          can :create, Topic
          can :create, Post
          can :update, Post, :author_id => user.id
        end
        can :search, Topic
      end
    else
      can :read, :all
      can :create, User
      can :search, Topic
    end
  end
end
