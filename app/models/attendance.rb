class Attendance < ActiveRecord::Base  
  validates_presence_of :user_id, :event_id
  belongs_to :user
  belongs_to :event
  
  validate :validate_unique_by_user_id_and_event_id
  
  private
  
    def validate_unique_by_user_id_and_event_id
      self.errors[:base] << "You already attend to this event" if Attendance.exists?(:user_id => self.user_id, :event_id => self.event_id)
    end
end