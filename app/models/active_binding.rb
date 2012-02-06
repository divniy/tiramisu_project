class ActiveBinding < ActiveRecord::Base
  belongs_to :user
  belongs_to :activable, :polymorphic => true
end
