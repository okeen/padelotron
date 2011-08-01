require 'spec_helper'

describe "games/index.html.erb" do
  before(:each) do
    assign(:games, [
      stub_model(Game,
        :team1_id => 1,
        :team2_id => 1,
        :game_type => "Game Type"
      ),
      stub_model(Game,
        :team1_id => 1,
        :team2_id => 1,
        :game_type => "Game Type"
      )
    ])
  end

  it "renders a list of games" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Game Type".to_s, :count => 2
  end
end
