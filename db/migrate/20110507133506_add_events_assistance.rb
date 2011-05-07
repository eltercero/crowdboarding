class AddEventsAssistance < ActiveRecord::Migration
  def self.up
    create_table :attendances, :force => true do |t|
      t.integer :user_id
      t.integer :event_id
      t.timestamps
    end
    
    add_index :attendances, :user_id
    add_index :attendances, :event_id
  end

  def self.down
    remove_index :attendances, :user_id
    
    drop_table :attendances
  end
end
