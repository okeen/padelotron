require 'spec_helper'

describe "achievements/index.html.erb" do
  before(:each) do
    assign(:achievements, [
      stub_model(Achievement,
        :stat => nil,
        :achievement_type => nil,
        :read => false,
        :message => "MyText"
      ),
      stub_model(Achievement,
        :stat => nil,
        :achievement_type => nil,
        :read => false,
        :message => "MyText"
      )
    ])
  end

  it "renders a list of achievements" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
