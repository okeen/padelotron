require 'spec_helper'

describe "notifications/edit.html.erb" do
  before(:each) do
    @notification = assign(:notification, stub_model(Notification,
      :player => "",
      :notification_type => nil,
      :params => "MyText",
      :read => false
    ))
  end

  it "renders the edit notification form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => notifications_path(@notification), :method => "post" do
      assert_select "input#notification_player", :name => "notification[player]"
      assert_select "input#notification_notification_type", :name => "notification[notification_type]"
      assert_select "textarea#notification_params", :name => "notification[params]"
      assert_select "input#notification_read", :name => "notification[read]"
    end
  end
end
