class Project < ActiveRecord::Base
  attr_accessible :name

  belongs_to :account

  has_one :owner, :through => :account

  validates :name, :presence => true
end
