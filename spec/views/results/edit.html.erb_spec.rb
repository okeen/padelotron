require 'spec_helper'

describe "results/edit.html.erb" do
  before(:each) do
    @result = assign(:result, stub_model(Result,
      :game_id => 1,
      :result_sets => "MyText",
      :status => "MyString"
    ))
  end

  it "renders the edit result form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => results_path(@result), :method => "post" do
      assert_select "input#result_game_id", :name => "result[game_id]"
      assert_select "textarea#result_result_sets", :name => "result[result_sets]"
      assert_select "input#result_status", :name => "result[status]"
    end
  end
end
