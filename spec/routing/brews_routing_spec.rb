require "rails_helper"

RSpec.describe BrewsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/brews").to route_to("brews#index")
    end

    it "routes to #new" do
      expect(get: "/brews/new").to route_to("brews#new")
    end

    it "routes to #show" do
      expect(get: "/brews/1").to route_to("brews#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/brews/1/edit").to route_to("brews#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/brews").to route_to("brews#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/brews/1").to route_to("brews#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/brews/1").to route_to("brews#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/brews/1").to route_to("brews#destroy", id: "1")
    end
  end
end
