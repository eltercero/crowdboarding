require 'spec_helper'

describe "Event pages" do
  it "GET events page" do
    get events_path
    response.status.should be(200)
  end
end