class Comment < ActiveRecord::Base
  has_ancestry
  attr_accessible :body
  validates_presence_of :body
  
  belongs_to :user
  belongs_to :commentable, :polymorphic => true
end