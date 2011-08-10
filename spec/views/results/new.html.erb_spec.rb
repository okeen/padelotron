require 'spec_helper'

describe "results/new.html.erb" do
  before(:each) do
    assign(:result, stub_model(Result,
      :game_id => 1,
      :result_sets => "MyText",
      :status => "MyString"
    ).as_new_record)
  end

  it "renders new result form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => results_path, :method => "post" do
      assert_select "input#result_game_id", :name => "result[game_id]"
      assert_select "textarea#result_result_sets", :name => "result[result_sets]"
      assert_select "input#result_status", :name => "result[status]"
    end
  end
end
