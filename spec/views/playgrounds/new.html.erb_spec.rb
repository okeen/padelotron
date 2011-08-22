require 'spec_helper'

describe "playgrounds/new.html.erb" do
  before(:each) do
    assign(:playground, stub_model(Playground,
      :name => "MyString",
      :sport => "MyString",
      :number => 1,
      :place => nil
    ).as_new_record)
  end

  it "renders new playground form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => playgrounds_path, :method => "post" do
      assert_select "input#playground_name", :name => "playground[name]"
      assert_select "input#playground_sport", :name => "playground[sport]"
      assert_select "input#playground_number", :name => "playground[number]"
      assert_select "input#playground_place", :name => "playground[place]"
    end
  end
end
