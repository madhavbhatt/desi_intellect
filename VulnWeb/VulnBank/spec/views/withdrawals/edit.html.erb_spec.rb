require 'rails_helper'

RSpec.describe "withdrawals/edit", type: :view do
  before(:each) do
    @withdrawal = assign(:withdrawal, Withdrawal.create!(
      :user_id => 1,
      :admin_id => 1,
      :amount => 1.5,
      :status => "MyString"
    ))
  end

  it "renders the edit withdrawal form" do
    render

    assert_select "form[action=?][method=?]", withdrawal_path(@withdrawal), "post" do

      assert_select "input#withdrawal_user_id[name=?]", "withdrawal[user_id]"

      assert_select "input#withdrawal_admin_id[name=?]", "withdrawal[admin_id]"

      assert_select "input#withdrawal_amount[name=?]", "withdrawal[amount]"

      assert_select "input#withdrawal_status[name=?]", "withdrawal[status]"
    end
  end
end
