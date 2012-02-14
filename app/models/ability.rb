class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.is? :customer
      can [:read, :activate, :destroy], Account
      can :create, Account if user.accounts.unpaid.count < 2
      can :pay, Account # Not really so simple
    end

    if user.is? :single
      can :manage, Account
      cannot :create, Account, :role => 'single'
      cannot :destroy, Account, :state => 'active'

      can [:read, :update, :delete], Project
      can :create, Project if user.active_account.projects.count < 2
    end

    if user.is? :startup
      can [:read, :activate], Account
    end
  end


end
