class CreateAdminUsers < ActiveRecord::Migration

  def self.up
    create_table :admin_users do |t|
      t.string :first_name, :default => "", :null => false
      t.string :last_name, :default => "", :null => false
      t.string :role, :null => false
      t.string :email, :null => false
      t.boolean :status, :default => false
      t.string :token, :null => false
      t.string :salt, :null => false
      t.string :crypted_password, :null => false
      t.string :preferences
      t.timestamps
    end
    add_index :admin_users, :email, :unique => true
    
    user = AdminUser.create!(:first_name => "Michael", :last_name => 'Koper', :role => 'admin', :email => "michaelkoper@gmail.com", :password => 'crowdboardingizawesome', :password_confirmation => 'crowdboardingizawesome', :preferences => {:lacale => "en"})
    user.status = true
    user.save
    user = AdminUser.create!(:first_name => 'Victor Martin', :last_name => "Ramirez", :role => 'admin', :email => "ilovemayalopez@gmail.com", :password => 'crowdboardingizawesome', :password_confirmation => 'crowdboardingizawesome', :preferences => {:lacale => "en"})
    user.status = true
    user.save
  end

  def self.down
    drop_table :admin_users
  end

end
