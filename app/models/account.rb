class Account < ActiveRecord::Base
  # Aliases
  alias_attribute :type, :role
  # Attributes
  attr_accessible :name, :type, :role

  # Associations

  belongs_to :owner, :class_name => 'User', :inverse_of => :accounts
  has_one :active_binding, :as => :activable

  # Validators

  validates :owner, :type, :presence => true

  # Callbacks

  after_create :activate

  # Methods

  def self.roles
    ROLES
  end

  def activate
    if owner.nil? then raise ActiveRecord::Rollback end
    owner.active_account = self
  end

  def active?
    !active_binding.nil?
  end

  private

  ROLES = %w[single startup teamlead director]

end
