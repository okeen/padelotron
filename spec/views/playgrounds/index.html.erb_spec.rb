require 'spec_helper'

describe "playgrounds/index.html.erb" do
  before(:each) do
    assign(:playgrounds, [
      stub_model(Playground,
        :name => "Name",
        :sport => "Sport",
        :number => 1,
        :place => nil
      ),
      stub_model(Playground,
        :name => "Name",
        :sport => "Sport",
        :number => 1,
        :place => nil
      )
    ])
  end

  it "renders a list of playgrounds" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Sport".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
