class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    can [:read, :destroy], Account, :owner_id => user.id
    #if user.is? :customer
    #  can [:read, :activate, :destroy], Account
    #  can :create, User::Account if user.accounts.unpaid.count < 2
    #  can :pay, User::Account # Not really so simple
    #end
    #
    #if user.is? :single
    #  can :manage, User::Account
    #  cannot :create, User::Account, :role => 'single'
    #  cannot :destroy, User::Account, :state => 'active'
    #
    #  can [:read, :update, :delete], Project
    #  can :create, Project if user.active_account.projects.count < 2
    #end
    #
    #if user.is? :startup
    #  can [:read, :activate], User::Account
    #end
  end


end
