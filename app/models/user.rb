class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, :length => { :maximum => 100 }
  validates :nickname,:uniqueness => true, :length => { :maximum => 40 }
  
  attr_accessible :name, :nickname, :default_city_id, :birthdate, 
                  :bio, :quiver, :email, :password, :avatar,
                  :password_confirmation, :remember_me, :id
  
  before_create :downcase_email, :create_nickname
  
  has_many :events
  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user
  has_many :attendances
  has_many :events_attended, :through => :attendances, :source => :event
  belongs_to :default_city, :class_name => 'City'
  
  has_attached_file :avatar, 
                    :styles => { :thumb => "220x220#", :small => "25x25#" },
                    :default_url => "missing_images/avatars/missing_:style.png",
                    :storage => :s3,
                    :path => "public/images/users/avatars/:id/:style.:extension",
                    :bucket => "onlinegeschenkenwinkel-#{Rails.env}",
                    :s3_credentials => {
                      :access_key_id => 'AKIAIIRSRZPHDO6V6PFQ',
                      :secret_access_key => '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' }
  
  def get_age
    ((Time.now - self.birthdate.to_time)/1.year).to_i
  end
  
  def is_a_friend?(user)
    Friendship.exists?(:user_id => self, :friend_id => user)
  end
  
  def attendance(event)
    @attendance ||= self.attendances.where(:event_id => event.id).try(:first)
  end
  
  private
  
    def downcase_email
      self.email.downcase!
    end
    
    def create_nickname
      self.nickname = self.email.split('@').first[0..40]
    end
end
