class User < ActiveRecord::Base
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable (:trackable, :recoverable, :validatable)
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :fullname, :accounts_attributes

  has_many :accounts, :foreign_key => :owner_id, :dependent => :destroy,
           :inverse_of => :owner

  accepts_nested_attributes_for :accounts

  has_one :active_account, :class_name => "Account", :foreign_key => :owner_id,
          :conditions => { :state => :active }, :readonly => true

  def is?(asked_role)
    role == asked_role.to_sym
  end

  def role
    active_account.role.to_sym
  end



  #has_many :projects, :through => :active_account

  #Methods
end
