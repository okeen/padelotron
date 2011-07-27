require 'spec_helper'

describe "teams/edit.html.erb" do
  before(:each) do
    @team = assign(:team, stub_model(Team,
      :name => "MyString",
      :player1_id => 1,
      :player2_id => 1,
      :status => "MyString"
    ))
  end

  it "renders the edit team form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => teams_path(@team), :method => "post" do
      assert_select "input#team_name", :name => "team[name]"
      assert_select "input#team_player1_id", :name => "team[player1_id]"
      assert_select "input#team_player2_id", :name => "team[player2_id]"
      assert_select "input#team_status", :name => "team[status]"
    end
  end
end
