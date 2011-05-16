class CreateEvent < ActiveRecord::Migration
  def self.up
    create_table :events, :force => true do |t|
      t.references :user
      t.string :name, :limit => 100
      t.datetime :starts_at
      t.text :description
      t.string :address, :limit => 100
      t.integer :country_id
      t.integer :city_id
      t.string :contact_details, :limit => 100
      t.float :lat
      t.float :lng
      t.integer :users_count, :default => 0
      t.integer :comments_count, :default => 0
      t.timestamps
    end
    add_index :events, :country_id
    add_index :events, :city_id
  end

  def self.down
    drop_table :events
  end
end