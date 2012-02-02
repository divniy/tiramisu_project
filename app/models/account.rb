class Account < ActiveRecord::Base
  # Aliases
  alias_attribute :type, :role
  # Attributes
  attr_accessible :name, :type



  # Associations

  belongs_to :owner, :class_name => 'User', :inverse_of => :accounts

  # Validators

  validates :type, :presence => true




  def has_roles
    self.class.roles
  end

  def self.roles
    ROLES
  end

  private

    ROLES = %w[single startup teamlead director]

end
