class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, :length => { :maximum => 100 }
  validates :nickname,:uniqueness => true, :length => { :maximum => 40 }
  
  attr_accessible :name, :nickname, :default_city_id, :birthdate, 
                  :bio, :quiver, :email, :password, :avatar,
                  :password_confirmation, :remember_me, :event_friend_updates
  
  before_create :downcase_email, :create_nickname
  
  has_many :events
  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user
  has_many :attendances
  has_many :events_attended, :through => :attendances, :source => :event
  has_many :authentications
  belongs_to :default_city, :class_name => 'City'
  
  
  has_attached_file :avatar, 
                    :styles => { :thumb => "220x220#", :medium => "60x60", :small => "25x25#" },
                    :default_url => "missing_images/avatars/missing_:style.png",
                    :storage => :s3,
                    :path => "public/images/users/avatars/:id/:style.:extension",
                    :bucket => "onlinegeschenkenwinkel-#{Rails.env}",
                    :s3_credentials => {
                      :access_key_id => ENV['S3_KEY'],
                      :secret_access_key => ENV['S3_SECRET']
                    }
  
  def get_age
    ((Time.now - self.birthdate.to_time)/1.year).to_i
  end
  
  def is_a_friend?(user)
    Friendship.exists?(:user_id => self, :friend_id => user)
  end
  
  def attendance(event)
    @attendance ||= self.attendances.where(:event_id => event.id).try(:first)
  end
  
  def print_name
    nickname || name
  end
  
  def admin?
    %w(ilovemayalopez@gmail.com michaelkoper@gmail.com).include? email
  end
  
  def apply_omniauth(omniauth)
    self.email = omniauth['user_info']['email'] if email.blank?
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end
  
  def password_required?
    (authentications.empty? || !password.blank?) && super
  end
  
  private
  
    def downcase_email
      self.email.downcase!
    end
    
    def create_nickname
      self.nickname = self.email.split('@').first[0..40]
    end
end
