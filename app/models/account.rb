class Account < ActiveRecord::Base
  belongs_to :owner
end
