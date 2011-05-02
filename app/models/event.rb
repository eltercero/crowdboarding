class Event < ActiveRecord::Base
  validates :name, :presence => true, :length => { :maximum => 100 }
  
  attr_accessible :name, :description, :address, :lat, :lng, :city_id
  
  belongs_to :user
  belongs_to :city
  has_many :users
  
  scope :recent, :order => "starts_at DESC"
  scope :from_now, :order => "starts_at DESC", :conditions => ["starts_at > ?", Time.now]
  
  def size_status
    case users_count
    when 0..10 then "small meeting"
    when 11..20 then "medium small meeting"
    else 
      "big mf meeting"
    end
  end
  
  def time_left
    rand(100)
  end
end