require 'spec_helper'

describe "subscriptions/index.html.erb" do
  before(:each) do
    assign(:subscriptions, [
      stub_model(Subscription,
        :type => "Type",
        :product_url => "Product Url",
        :customer => nil,
        :payment_to_date => false,
        :external_id => 1
      ),
      stub_model(Subscription,
        :type => "Type",
        :product_url => "Product Url",
        :customer => nil,
        :payment_to_date => false,
        :external_id => 1
      )
    ])
  end

  it "renders a list of subscriptions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Type".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Product Url".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
