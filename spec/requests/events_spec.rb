require 'spec_helper'

describe "Events" do
  before :each do
    create_user_and_login!
  end
  describe "GET /tasks" do
    it "displays the events" do
      Factory(:event, :name => "Friday Retiro")
      visit events_path
      # save_and_open_page
      page.should have_content("Friday Retiro")
    end
  end
  
  describe "POST /tasks" do
    it "creates a valid event" do
      Factory(:country)
      click_link "Add Event"
      fill_in "Name", :with => "Friday Retiro"
      select "Spain", :from => "Country"
      fill_in "City", :with => "Madrid"
      fill_in "Address", :with => "Calle Alcala 177 7B"
      fill_in "Contact details", :with => "1234567890"
      fill_in "Tag tokens", :with => "Retiro Longboard"
      fill_in "Enter Date", :with => "2011-06-24"
      click_button "Create Event"
      
      within('div.event') do
        find('h2').should have_content('Friday Retiro')
        find('h2').should have_link('edit')
      end
    end
    
    it "creates an invalid event" do
      click_link "Add Event"
      click_button "Create Event"
      page.should have_content("An error occured")
      page.should have_content("Name can't be blank")
    end
  end
end
