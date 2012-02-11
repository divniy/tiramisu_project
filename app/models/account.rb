class Account < ActiveRecord::Base
  # Aliases
  #alias_attribute :type, :role
  # Attributes
  attr_accessible :name, :role

  # Associations

  belongs_to :owner, :class_name => 'User', :inverse_of => :accounts

  has_many :projects

  # Validators

  validates :name, :role, :presence => true



  # Callbacks

  after_create :activate

  # State machine
  state_machine :initial => :off do
    state :off
    state :active

    event :activate do
      transition all => :active
    end

    event :deactivate do
      transition all => :off
    end

    before_transition any - :active => :active do |account|
      Account.active.find_by_owner_id(account.owner_id).try(:deactivate)
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
