require "rails_helper"

RSpec.describe WithdrawsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/withdraws").to route_to("withdraws#index")
    end

    it "routes to #new" do
      expect(:get => "/withdraws/new").to route_to("withdraws#new")
    end

    it "routes to #show" do
      expect(:get => "/withdraws/1").to route_to("withdraws#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/withdraws/1/edit").to route_to("withdraws#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/withdraws").to route_to("withdraws#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/withdraws/1").to route_to("withdraws#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/withdraws/1").to route_to("withdraws#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/withdraws/1").to route_to("withdraws#destroy", :id => "1")
    end

  end
end
