require "spec_helper"

describe ResultsController do
  describe "routing" do

    it "routes to #index" do
      get("/results").should route_to("results#index")
    end

    it "routes to #new" do
      get("/results/new").should route_to("results#new")
    end

    it "routes to #show" do
      get("/results/1").should route_to("results#show", :id => "1")
    end

    it "routes to #edit" do
      get("/results/1/edit").should route_to("results#edit", :id => "1")
    end

    it "routes to #create" do
      post("/results").should route_to("results#create")
    end

    it "routes to #update" do
      put("/results/1").should route_to("results#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/results/1").should route_to("results#destroy", :id => "1")
    end

  end
end
