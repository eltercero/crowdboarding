class Comment < ActiveRecord::Base
  has_ancestry
  attr_accessible :body
  
  belongs_to :event, :counter_cache => true
end