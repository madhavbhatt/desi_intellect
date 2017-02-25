require 'rails_helper'

RSpec.describe "Withdrawals", type: :request do
  describe "GET /withdrawals" do
    it "works! (now write some real specs)" do
      get withdrawals_path
      expect(response).to have_http_status(200)
    end
  end
end
