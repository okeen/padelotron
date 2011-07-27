require 'spec_helper'

describe "teams/index.html.erb" do
  before(:each) do
    assign(:teams, [
      stub_model(Team,
        :name => "Name",
        :player1_id => 1,
        :player2_id => 1,
        :status => "Status"
      ),
      stub_model(Team,
        :name => "Name",
        :player1_id => 1,
        :player2_id => 1,
        :status => "Status"
      )
    ])
  end

  it "renders a list of teams" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Status".to_s, :count => 2
  end
end
