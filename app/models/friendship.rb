class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, :class_name => 'User'
  
  validate :validate_unique_by_user_id_and_friend_id
  
  private
  
    def validate_unique_by_user_id_and_friend_id
      self.errors[:base] << "You already have this user as a friend" if Friendship.exists?(:user_id => self.user_id, :friend_id => self.friend_id)
    end
end