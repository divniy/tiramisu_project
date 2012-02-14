class Account < ActiveRecord::Base
  # Aliases
  #alias_attribute :type, :role
  # Attributes
  attr_accessible :name, :role, :state_event

  # Associations

  belongs_to :owner, :class_name => 'User', :inverse_of => :accounts

  has_many :projects

  # Validators

  validates :name, :role, :presence => true

  # Callbacks

  #after_create :activate

  # State machine
  state_machine :initial => :unpaid do
    state :unpaid
    state :paid
    state :active

    event :pay do
      transition :unpaid => :paid
    end

    event :activate do
      transition [:paid, :active] => :active
    end
    event :deactivate do
      transition [:active, :paid] => :paid
    end

    before_transition :paid => :active do |account|
      Account.where(:owner_id => account.owner_id).active.each do |acc|
        acc.deactivate
      end
    end
  end
  state_machine.states.each { |s| scope s.name, where(:state => s.name) }

  # Methods
  def self.roles
    ROLES
  end

  private

  ROLES = %w[single startup teamlead director]

end
