require 'spec_helper'

describe "places/index.html.erb" do
  before(:each) do
    assign(:places, [
      stub_model(Place,
        :name => "Name",
        :latitude => 1.5,
        :longitude => 1.5,
        :country => "Country",
        :state => "State",
        :city => "City",
        :address => "Address"
      ),
      stub_model(Place,
        :name => "Name",
        :latitude => 1.5,
        :longitude => 1.5,
        :country => "Country",
        :state => "State",
        :city => "City",
        :address => "Address"
      )
    ])
  end

  it "renders a list of places" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Country".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "State".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "City".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Address".to_s, :count => 2
  end
end
