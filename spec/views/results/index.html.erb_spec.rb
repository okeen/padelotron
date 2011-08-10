require 'spec_helper'

describe "results/index.html.erb" do
  before(:each) do
    assign(:results, [
      stub_model(Result,
        :game_id => 1,
        :result_sets => "MyText",
        :status => "Status"
      ),
      stub_model(Result,
        :game_id => 1,
        :result_sets => "MyText",
        :status => "Status"
      )
    ])
  end

  it "renders a list of results" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Status".to_s, :count => 2
  end
end
