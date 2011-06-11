require 'spec_helper'

describe "the signup process", :type => :request do
  it "signs me in" do
    create_user_and_login!
  end
end