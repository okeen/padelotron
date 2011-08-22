require 'spec_helper'

describe "playgrounds/show.html.erb" do
  before(:each) do
    @playground = assign(:playground, stub_model(Playground,
      :name => "Name",
      :sport => "Sport",
      :number => 1,
      :place => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Sport/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
  end
end
