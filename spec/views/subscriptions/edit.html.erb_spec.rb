require 'spec_helper'

describe "subscriptions/edit.html.erb" do
  before(:each) do
    @subscription = assign(:subscription, stub_model(Subscription,
      :type => "MyString",
      :product_url => "MyString",
      :customer => nil,
      :payment_to_date => false,
      :external_id => 1
    ))
  end

  it "renders the edit subscription form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => subscriptions_path(@subscription), :method => "post" do
      assert_select "input#subscription_type", :name => "subscription[type]"
      assert_select "input#subscription_product_url", :name => "subscription[product_url]"
      assert_select "input#subscription_customer", :name => "subscription[customer]"
      assert_select "input#subscription_payment_to_date", :name => "subscription[payment_to_date]"
      assert_select "input#subscription_external_id", :name => "subscription[external_id]"
    end
  end
end
