class User < ActiveRecord::Base

  attr_accessible :fullname, :email, :password, :password_confirmation, :remember_me,
                  :accounts_attributes

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable (:trackable, :recoverable, :validatable)
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  has_many :accounts, :foreign_key => :owner_id, :dependent => :destroy,
           :inverse_of => :owner

  has_one :active_account, :class_name => "Account", :foreign_key => :owner_id,
          :conditions => { :state => :active }

  has_many :projects, :through => :active_account

  accepts_nested_attributes_for :accounts

  #Methods



end
