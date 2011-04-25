class CreateCity < ActiveRecord::Migration
  def self.up
    create_table :cities, :force => true do |t|
      t.string :name, :limit => 100, :null => false
      t.references :country
    end
    country = Country.find_by_country_code("ES")
    country.cities.create!(:name => "Madrid")
    country.cities.create!(:name => "Barcelona")
    country.cities.create!(:name => "Valencia")
  end

  def self.down
    drop_table :cities
  end
end