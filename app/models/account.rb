class Account < ActiveRecord::Base

  attr_accessible :name, :role

  belongs_to :owner, :class_name => 'User', :inverse_of => :accounts

  validates :role, :presence => true

  def has_roles
    self.class.roles
  end

  def self.roles
    ROLES
  end

  private

    ROLES = %w[single startup teamlead director]

end
