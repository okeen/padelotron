require 'spec_helper'

describe "subscriptions/show.html.erb" do
  before(:each) do
    @subscription = assign(:subscription, stub_model(Subscription,
      :type => "Type",
      :product_url => "Product Url",
      :customer => nil,
      :payment_to_date => false,
      :external_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Type/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Product Url/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/false/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
