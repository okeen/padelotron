require 'spec_helper'

describe "customer_playground_requests/index.html.erb" do
  before(:each) do
    assign(:customer_playground_requests, [
      stub_model(Customer::PlaygroundRequest,
        :game => nil,
        :playground => nil,
        :accept_code => "Accept Code",
        :reject_code => "Reject Code",
        :status => "Status"
      ),
      stub_model(Customer::PlaygroundRequest,
        :game => nil,
        :playground => nil,
        :accept_code => "Accept Code",
        :reject_code => "Reject Code",
        :status => "Status"
      )
    ])
  end

  it "renders a list of customer_playground_requests" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Accept Code".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Reject Code".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Status".to_s, :count => 2
  end
end
