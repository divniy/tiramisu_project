class Account < ActiveRecord::Base
  # Aliases
  alias_attribute :type, :role
  # Attributes
  attr_accessible :name, :type, :role

  # Associations

  belongs_to :owner, :class_name => 'User', :inverse_of => :accounts

  # Validators

  validates :owner, :type, :presence => true

  # Callbacks

  after_create :activate

  # Methods

  def self.roles
    ROLES
  end

  # State machine
  state_machine :initial => :basic do
    before_transition any => :active do |account|
      account.owner.active_account.deactivate if !account.owner.active_account.nil?
    end
    event :activate do
      transition :basic => :active
    end
    event :deactivate do
      transition :active => :basic
    end
  end

  private

  ROLES = %w[single startup teamlead director]

end
