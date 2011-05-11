class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments, :force => true do |t|
      t.references :user
      t.string :ancestry
      t.text :body
      t.integer :commentable_id
      t.string :commentable_type, :limit => 14
      t.timestamps
    end
    add_index :comments, :user_id
    add_index :comments, :ancestry
    add_index :comments, [:commentable_id, :commentable_type], :name => "index_comments_on_commentable"
  end

  def self.down
    # remove_index :comments, :name => :index_comments_on_commentable
    remove_index :comments, :ancestry
    remove_index :comments, :user_id
    drop_table :comments
  end
end