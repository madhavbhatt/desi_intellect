require 'rails_helper'

RSpec.describe "withdraws/edit", type: :view do
  before(:each) do
    @withdraw = assign(:withdraw, Withdraw.create!(
      :user_id => 1,
      :amount => 1.5
    ))
  end

  it "renders the edit withdraw form" do
    render

    assert_select "form[action=?][method=?]", withdraw_path(@withdraw), "post" do

      assert_select "input#withdraw_user_id[name=?]", "withdraw[user_id]"

      assert_select "input#withdraw_amount[name=?]", "withdraw[amount]"
    end
  end
end
