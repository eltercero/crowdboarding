class CreateEvent < ActiveRecord::Migration
  def self.up
    create_table :events, :force => true do |t|
      t.references :user
      t.string :name, :limit => 100
      t.datetime :starts_at
      t.text :description
      t.string :address, :limit => 100
      t.float :lat
      t.float :lng
      t.integer :users_count, :default => 0
      t.integer :comments_count, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end