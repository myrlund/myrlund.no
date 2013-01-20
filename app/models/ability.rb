class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :drafts, to: :index
    
    can :read, :all
    
    if user && user.persisted?
      can :manage, :all
    end
  end
end
