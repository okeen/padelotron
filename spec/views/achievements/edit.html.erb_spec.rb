require 'spec_helper'

describe "achievements/edit.html.erb" do
  before(:each) do
    @achievement = assign(:achievement, stub_model(Achievement,
      :stat => nil,
      :achievement_type => nil,
      :read => false,
      :message => "MyText"
    ))
  end

  it "renders the edit achievement form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => achievements_path(@achievement), :method => "post" do
      assert_select "input#achievement_stat", :name => "achievement[stat]"
      assert_select "input#achievement_achievement_type", :name => "achievement[achievement_type]"
      assert_select "input#achievement_read", :name => "achievement[read]"
      assert_select "textarea#achievement_message", :name => "achievement[message]"
    end
  end
end
