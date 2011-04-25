class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments, :force => true do |t|
      t.references :user
      t.string :ancestry
      t.text :body
      t.timestamps
    end
    add_index :comments, :user_id
    add_index :comments, :ancestry
  end

  def self.down
    remove_index :comments, :ancestry
    remove_index :comments, :user_id
    drop_table :comments
  end
end