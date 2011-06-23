require 'spec_helper'

describe "the signup process", :type => :request do
  it "signs me in" do
    create_user_and_login!
  end
  
  it "signs up a new user successfuly" do
    visit(root_path)
    click_link "Register"
    fill_in "Email", :with => "email@crowdboarding.com"
    fill_in "Password", :with => "secret"
    fill_in "Password confirmation", :with => "secret"
    click_button "Sign up"
    page.should have_content("Welcome! You have signed up successfully.")
    current_path.should == welcome_path
  end
end