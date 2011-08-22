require 'spec_helper'

describe "playgrounds/edit.html.erb" do
  before(:each) do
    @playground = assign(:playground, stub_model(Playground,
      :name => "MyString",
      :sport => "MyString",
      :number => 1,
      :place => nil
    ))
  end

  it "renders the edit playground form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => playgrounds_path(@playground), :method => "post" do
      assert_select "input#playground_name", :name => "playground[name]"
      assert_select "input#playground_sport", :name => "playground[sport]"
      assert_select "input#playground_number", :name => "playground[number]"
      assert_select "input#playground_place", :name => "playground[place]"
    end
  end
end
