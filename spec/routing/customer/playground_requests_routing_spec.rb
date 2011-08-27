require "spec_helper"

describe Customer::PlaygroundRequestsController do
  describe "routing" do

    it "routes to #index" do
      get("/customer_playground_requests").should route_to("customer_playground_requests#index")
    end

    it "routes to #new" do
      get("/customer_playground_requests/new").should route_to("customer_playground_requests#new")
    end

    it "routes to #show" do
      get("/customer_playground_requests/1").should route_to("customer_playground_requests#show", :id => "1")
    end

    it "routes to #edit" do
      get("/customer_playground_requests/1/edit").should route_to("customer_playground_requests#edit", :id => "1")
    end

    it "routes to #create" do
      post("/customer_playground_requests").should route_to("customer_playground_requests#create")
    end

    it "routes to #update" do
      put("/customer_playground_requests/1").should route_to("customer_playground_requests#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/customer_playground_requests/1").should route_to("customer_playground_requests#destroy", :id => "1")
    end

  end
end
