class Tag < ActiveRecord::Base
  before_create :downcase_name
  
  private
    def downcase_name
      self.name.try(:downcase)
    end
end