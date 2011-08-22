require 'spec_helper'

describe "achievements/new.html.erb" do
  before(:each) do
    assign(:achievement, stub_model(Achievement,
      :stat => nil,
      :achievement_type => nil,
      :read => false,
      :message => "MyText"
    ).as_new_record)
  end

  it "renders new achievement form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => achievements_path, :method => "post" do
      assert_select "input#achievement_stat", :name => "achievement[stat]"
      assert_select "input#achievement_achievement_type", :name => "achievement[achievement_type]"
      assert_select "input#achievement_read", :name => "achievement[read]"
      assert_select "textarea#achievement_message", :name => "achievement[message]"
    end
  end
end
