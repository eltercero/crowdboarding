class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  validates :name, :uniqueness => true, :length => { :maximum => 40 }
  
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  before_create :downcase_email, :create_nickname
  
  has_many :events
  
  private
  
    def downcase_email
      self.email.downcase!
    end
    
    def create_nickname
      self.nickname = self.email.split('@').first[0..40]
    end
end
