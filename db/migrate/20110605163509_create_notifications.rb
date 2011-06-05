class CreateNotifications < ActiveRecord::Migration
  def self.up
    create_table :notifications do |t|
      t.integer :user_id
      t.string :body, :limit => 100
      t.boolean :read, :default => false
      t.timestamps
    end
    add_index :notifications, :user_id
  end

  def self.down
    remove_index :notifications, :user_id
    drop_table :notifications
  end
end
