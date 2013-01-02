class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all
    
    if user && user.persisted?
      can :manage, :all
    end
  end
end
