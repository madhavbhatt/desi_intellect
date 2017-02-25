require 'rails_helper'

RSpec.describe "withdraws/new", type: :view do
  before(:each) do
    assign(:withdraw, Withdraw.new(
      :user_id => 1,
      :amount => 1.5
    ))
  end

  it "renders new withdraw form" do
    render

    assert_select "form[action=?][method=?]", withdraws_path, "post" do

      assert_select "input#withdraw_user_id[name=?]", "withdraw[user_id]"

      assert_select "input#withdraw_amount[name=?]", "withdraw[amount]"
    end
  end
end
