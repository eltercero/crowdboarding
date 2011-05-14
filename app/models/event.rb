class Event < ActiveRecord::Base
  validates :name, :presence => true, :length => { :maximum => 100 }
  validates :contact_details, :length => { :maximum => 100 }
  validates :city_id, :presence => true
  validates :starts_at, :presence => true
  validates :address, :presence => true
  validate :minimum_tags
  validate :maximum_tags

  acts_as_gmappable :lat => 'lat', :lng => "lng", :check_process => false
  acts_as_taggable
  
  attr_accessible :name, :description, :address, :lat, :lng, :city_id, :contact_details, :tag_tokens
  
  belongs_to :user
  belongs_to :city
  has_many :users
  has_many :attendances
  has_many :attenders, :through => :attendances, :source => :user
  has_many :comments, :as => :commentable
  
  attr_reader :tag_tokens
  
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
  
  def gmaps4rails_address
    "#{self.address}, #{self.city.try(:name)}, #{self.city.try(:country).try(:name)}"
  end
  
  def gmaps4rails_infowindow
    "<b>Longboard event</b><br/>#{self.address}, #{self.city.try(:name)}. <a href=''>#{self.user.nickname}</a>"
  end
  
  def gmaps4rails_marker_picture
   {
    "picture" => "http://crowdboarding.heroku.com/images/gmaps_marker.png",
    "width" => "32",
    "height" => "32"
   }
  end
  
  def weather
    # We really need a rescue here? If so, please rescue with an exception
    begin
      Barometer.google_geocode_key = "ABQIAAAAkL8Sj3wtXBYcuftZ8wb4UBQhNMPAV3DsEOaCg1R_7cZ76nRoThSXibb4kLuzvHipgIom_C8VtxOfbw"
      barometer = Barometer.new("#{self.city.name}, #{self.city.country.name}")
      weather = barometer.measure
      forecast = weather.for(self.starts_at)
    rescue ArgumentError 
      forecast = nil
    end

    if forecast.nil?
      return {:high => 'n/a', :icon => 'unknown'}
    else
      icon = if ['nt_flurries','nt_rain','nt_sleet', 'nt_snow','nt_tstorms','chancerain','chancetstorms'].include? forecast.icon
        'rain'
      else #!clear !mostlysunny !partlysunny !sunny partlycloudy
        forecast.icon
      end

      return {:high => forecast.high.c, :icon => icon}     
    end
  end
  
  def tag_tokens=(tags)
    self.tag_list = tags.try(:squeeze).try(:split, /(\s|,|,\s|\s,|\s,\s)/)
  end
  
  private
    def minimum_tags
      self.errors.add(:tag_tokens, "we need at least 1 tag") if self.tag_list.length < 1
    end
    
    def maximum_tags
      self.errors.add(:tag_tokens, "maximal 5 tags allowed") if self.tag_list.length > 5
    end
end