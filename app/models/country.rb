class Country < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true, :length => { :maximum => 100 }
  validates :country_code, :presence => true, :uniqueness => true, :length => { :is => 2 }
  validates :country_code_big, :presence => true, :uniqueness => true, :length => { :is => 3 }

  has_many :cities
end