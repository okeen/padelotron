require 'spec_helper'

describe "places/edit.html.erb" do
  before(:each) do
    @place = assign(:place, stub_model(Place,
      :name => "MyString",
      :latitude => 1.5,
      :longitude => 1.5,
      :country => "MyString",
      :state => "MyString",
      :city => "MyString",
      :address => "MyString"
    ))
  end

  it "renders the edit place form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => places_path(@place), :method => "post" do
      assert_select "input#place_name", :name => "place[name]"
      assert_select "input#place_latitude", :name => "place[latitude]"
      assert_select "input#place_longitude", :name => "place[longitude]"
      assert_select "input#place_country", :name => "place[country]"
      assert_select "input#place_state", :name => "place[state]"
      assert_select "input#place_city", :name => "place[city]"
      assert_select "input#place_address", :name => "place[address]"
    end
  end
end
