class CreateAuthentication < ActiveRecord::Migration
  def self.up
    create_table :authentications, :force => true do |t|
      t.integer :user_id
      t.string :provider, :limit => 20
      t.string :uid
      t.timestamps
    end
    add_index :authentications, :user_id
  end

  def self.down
    drop_table :authentications
  end
end
