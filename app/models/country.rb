class Country < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true, :length => { :maximum => 100 }
  validates :country_code, :presence => true, :uniqueness => true, :length => { :is => 2 }

  has_many :cities
  
  before_create :downcase_name, :titleize_name, :downcase_country_code
  
  def name_without_comma
    name.gsub(",","")
  end
  
  private    
    def downcase_name
      self.name.downcase!
    end
    
    def titleize_name
      self.name = self.name.titleize
    end
    
    def downcase_country_code
      self.country_code.downcase!
    end
end