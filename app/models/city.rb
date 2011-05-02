class City < ActiveRecord::Base
  validates_presence_of :name, :country_id
  
  belongs_to :country
  
  def get_city_and_country
    return "#{self.name}, #{self.country.name}"
  end
end