require 'spec_helper'

describe "customer_playground_requests/show.html.erb" do
  before(:each) do
    @playground_request = assign(:playground_request, stub_model(Customer::PlaygroundRequest,
      :game => nil,
      :playground => nil,
      :accept_code => "Accept Code",
      :reject_code => "Reject Code",
      :status => "Status"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Accept Code/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Reject Code/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Status/)
  end
end
