require 'rails_helper'

RSpec.describe "Borrows", type: :request do
  describe "GET /borrows" do
    it "works! (now write some real specs)" do
      get borrows_path
      expect(response).to have_http_status(200)
    end
  end
end
