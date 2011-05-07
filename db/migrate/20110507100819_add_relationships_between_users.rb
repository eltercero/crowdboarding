class AddRelationshipsBetweenUsers < ActiveRecord::Migration
  def self.up
    create_table :relationships, :force => true, :id => false do |t|
      t.integer :user_id, :null => false
      t.integer :related_user_id, :null => false
      t.string :type, :limit => 32
      t.timestamps
    end
    add_index :relationships, :user_id
    add_index :relationships, :related_user_id
  end

  def self.down
    drop_table :relationships
  end
end
