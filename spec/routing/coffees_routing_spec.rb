require "rails_helper"

RSpec.describe CoffeesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/coffees").to route_to("coffees#index")
    end

    it "routes to #new" do
      expect(get: "/coffees/new").to route_to("coffees#new")
    end

    it "routes to #show" do
      expect(get: "/coffees/1").to route_to("coffees#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/coffees/1/edit").to route_to("coffees#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/coffees").to route_to("coffees#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/coffees/1").to route_to("coffees#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/coffees/1").to route_to("coffees#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/coffees/1").to route_to("coffees#destroy", id: "1")
    end
  end
end
