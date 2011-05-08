class Relationship < ActiveRecord::Base
  belongs_to :user
  belongs_to :related_user, :class_name => 'User'
  
  validate :validate_unique_by_user_id_and_related_user_id
  
  private
  
    def validate_unique_by_user_id_and_related_user_id
      self.errors[:base] << "You already have this user as a friend" if Relationship.exists?(:user_id => self.user_id, :related_user_id => self.related_user_id)
    end
end