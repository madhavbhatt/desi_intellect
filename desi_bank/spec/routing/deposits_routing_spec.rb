require "rails_helper"

RSpec.describe DepositsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/deposits").to route_to("deposits#index")
    end

    it "routes to #new" do
      expect(:get => "/deposits/new").to route_to("deposits#new")
    end

    it "routes to #show" do
      expect(:get => "/deposits/1").to route_to("deposits#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/deposits/1/edit").to route_to("deposits#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/deposits").to route_to("deposits#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/deposits/1").to route_to("deposits#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/deposits/1").to route_to("deposits#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/deposits/1").to route_to("deposits#destroy", :id => "1")
    end

  end
end
