require 'spec_helper'

describe "games/new.html.erb" do
  before(:each) do
    assign(:game, stub_model(Game,
      :team1_id => 1,
      :team2_id => 1,
      :game_type => "MyString"
    ).as_new_record)
  end

  it "renders new game form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => games_path, :method => "post" do
      assert_select "input#game_team1_id", :name => "game[team1_id]"
      assert_select "input#game_team2_id", :name => "game[team2_id]"
      assert_select "input#game_game_type", :name => "game[game_type]"
    end
  end
end
