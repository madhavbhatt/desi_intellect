require "rails_helper"

RSpec.describe BorrowsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/borrows").to route_to("borrows#index")
    end

    it "routes to #new" do
      expect(:get => "/borrows/new").to route_to("borrows#new")
    end

    it "routes to #show" do
      expect(:get => "/borrows/1").to route_to("borrows#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/borrows/1/edit").to route_to("borrows#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/borrows").to route_to("borrows#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/borrows/1").to route_to("borrows#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/borrows/1").to route_to("borrows#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/borrows/1").to route_to("borrows#destroy", :id => "1")
    end

  end
end
