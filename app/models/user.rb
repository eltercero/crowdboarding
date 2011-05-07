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
  has_many :relationships
  has_many :related_users, :through => :relationships
  has_many :inverse_relationships, :class_name => "Relationship", :foreign_key => "related_user_id"
  has_many :inverse_related_users, :through => :inverse_relationships, :source => :user
  has_many :attendances
  has_many :events_attended, :through => :attendances, :source => :event
  belongs_to :default_city, :class_name => 'City'
  
  has_attached_file :avatar, 
                    :styles => { :thumb => "220x220#", :small => "25x25#" },
                    :default_url => "missing_images/avatars/missing_:style.png",
                    :storage => :s3,
                    :path => "public/images/users/avatars/:id/:style.:extension",
                    :bucket => "onlinegeschenkenwinkel-#{RAILS_ENV}",
                    :s3_credentials => {
                      :access_key_id => 'AKIAIIRSRZPHDO6V6PFQ',
                      :secret_access_key => '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' }
  
  def get_age
    ((Time.now - self.birthdate.to_time)/1.year).to_i
  end
  
  def is_a_friend?(user)
    Relationship.exists?(:user_id => self, :related_user_id => user)
  end
  
  def is_attending?(event)
    Attendance.exists?(:user_id => self, :event_id => event)
  end
  
  private
  
    def downcase_email
      self.email.downcase!
    end
    
    def create_nickname
      self.nickname = self.email.split('@').first[0..40]
    end
end
