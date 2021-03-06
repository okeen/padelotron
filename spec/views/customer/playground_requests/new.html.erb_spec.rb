require 'spec_helper'

describe "customer_playground_requests/new.html.erb" do
  before(:each) do
    assign(:playground_request, stub_model(Customer::PlaygroundRequest,
      :game => nil,
      :playground => nil,
      :accept_code => "MyString",
      :reject_code => "MyString",
      :status => "MyString"
    ).as_new_record)
  end

  it "renders new playground_request form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => customer_playground_requests_path, :method => "post" do
      assert_select "input#playground_request_game", :name => "playground_request[game]"
      assert_select "input#playground_request_playground", :name => "playground_request[playground]"
      assert_select "input#playground_request_accept_code", :name => "playground_request[accept_code]"
      assert_select "input#playground_request_reject_code", :name => "playground_request[reject_code]"
      assert_select "input#playground_request_status", :name => "playground_request[status]"
    end
  end
end
