require 'spec_helper'

describe "StaticPages" do
  it "Get root page" do
    get root_path
    response.status.should be(200)
  end
  
  it "GET about page" do
    get about_path
    response.status.should be(200)
  end
  
  it "GET contact page" do
    get contact_path
    response.status.should be(200)
  end
  
  it "GET help page" do
    get help_path
    response.status.should be(200)
  end
end