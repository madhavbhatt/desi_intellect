require 'rails_helper'

RSpec.describe "Transfers", type: :request do
  describe "GET /transfers" do
    it "works! (now write some real specs)" do
      get transfers_path
      expect(response).to have_http_status(200)
    end
  end
end
