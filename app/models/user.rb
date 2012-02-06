class User < ActiveRecord::Base

  attr_accessible :fullname, :email, :password, :password_confirmation, :remember_me,
                  :accounts_attributes, :account

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable (:trackable, :recoverable, :validatable)
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  has_many :accounts, :foreign_key => :owner_id, :dependent => :destroy,
           :inverse_of => :owner

  has_many :active_bindings, :dependent => :destroy

  has_one :account_binding, :class_name => "ActiveBinding", :conditions => { :activable_type => "Account" }
  has_one :active_account, :through => :account_binding, :source => :activable, :source_type => "Account"


  accepts_nested_attributes_for :accounts

  #Methods



end
