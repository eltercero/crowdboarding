class CreateCity < ActiveRecord::Migration
  def self.up
    create_table :cities, :force => true do |t|
      t.string :name, :limit => 100, :null => false
    end

    City.create!(:name => "Madrid")
    City.create!(:name => "Barcelona")
    City.create!(:name => "Valencia")
    City.create!(:name => "Sevilla")
  end

  def self.down
    drop_table :cities
  end
end