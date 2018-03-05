require "rails_helper"

RSpec.describe TransfersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/transfers").to route_to("transfers#index")
    end

    it "routes to #new" do
      expect(:get => "/transfers/new").to route_to("transfers#new")
    end

    it "routes to #show" do
      expect(:get => "/transfers/1").to route_to("transfers#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/transfers/1/edit").to route_to("transfers#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/transfers").to route_to("transfers#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/transfers/1").to route_to("transfers#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/transfers/1").to route_to("transfers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/transfers/1").to route_to("transfers#destroy", :id => "1")
    end

  end
end
