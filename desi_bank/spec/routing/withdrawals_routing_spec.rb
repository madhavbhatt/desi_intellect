require "rails_helper"

RSpec.describe WithdrawalsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/withdrawals").to route_to("withdrawals#index")
    end

    it "routes to #new" do
      expect(:get => "/withdrawals/new").to route_to("withdrawals#new")
    end

    it "routes to #show" do
      expect(:get => "/withdrawals/1").to route_to("withdrawals#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/withdrawals/1/edit").to route_to("withdrawals#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/withdrawals").to route_to("withdrawals#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/withdrawals/1").to route_to("withdrawals#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/withdrawals/1").to route_to("withdrawals#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/withdrawals/1").to route_to("withdrawals#destroy", :id => "1")
    end

  end
end
