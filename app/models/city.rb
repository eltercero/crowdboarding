class City < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true, :length => { :maximum => 100 }
  
  before_create :downcase_name
  
  private
    def downcase_name
      self.name.downcase!
    end
end