class Event < ActiveRecord::Base
  validates :name, :presence => true, :length => { :maximum => 100 }
  
  attr_accessible :name, :starts_at, :description
  
  belongs_to :user
  has_many :users
  
  scope :recent, :order => "starts_at DESC"
  
  def size_status
    case users_count
    when 0..10 then "small meeting"
    when 11..20 then "medium small meeting"
    else 
      "big mf meeting"
    end
  end
end