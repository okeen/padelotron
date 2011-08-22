require "spec_helper"

describe AchievementsController do
  describe "routing" do

    it "routes to #index" do
      get("/achievements").should route_to("achievements#index")
    end

    it "routes to #new" do
      get("/achievements/new").should route_to("achievements#new")
    end

    it "routes to #show" do
      get("/achievements/1").should route_to("achievements#show", :id => "1")
    end

    it "routes to #edit" do
      get("/achievements/1/edit").should route_to("achievements#edit", :id => "1")
    end

    it "routes to #create" do
      post("/achievements").should route_to("achievements#create")
    end

    it "routes to #update" do
      put("/achievements/1").should route_to("achievements#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/achievements/1").should route_to("achievements#destroy", :id => "1")
    end

  end
end
