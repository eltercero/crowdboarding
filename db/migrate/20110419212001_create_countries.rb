class CreateCountries < ActiveRecord::Migration
  def self.up
    create_table :countries, :force => true do |t|
      t.string :name, :null => false, :limits => 100
      t.string :country_code, :null => false, :limits => 2
    end
    add_index :countries, :name, :unique => true
    add_index :countries, :country_code, :unique => true
    
    require 'csv'
    path = RAILS_ROOT + "/lib/iso_import_files/all_countries.csv"
    CSV.foreach(path, :col_sep => ";") do |country|
      Country.create!(:name => country[0], :country_code => country[1].strip)
     end
  end

  def self.down
    remove_index :countries, :country_code
    remove_index :countries, :name
    drop_table :countries
  end
end