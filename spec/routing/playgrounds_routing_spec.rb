require "spec_helper"

describe PlaygroundsController do
  describe "routing" do

    it "routes to #index" do
      get("/playgrounds").should route_to("playgrounds#index")
    end

    it "routes to #new" do
      get("/playgrounds/new").should route_to("playgrounds#new")
    end

    it "routes to #show" do
      get("/playgrounds/1").should route_to("playgrounds#show", :id => "1")
    end

    it "routes to #edit" do
      get("/playgrounds/1/edit").should route_to("playgrounds#edit", :id => "1")
    end

    it "routes to #create" do
      post("/playgrounds").should route_to("playgrounds#create")
    end

    it "routes to #update" do
      put("/playgrounds/1").should route_to("playgrounds#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/playgrounds/1").should route_to("playgrounds#destroy", :id => "1")
    end

  end
end
