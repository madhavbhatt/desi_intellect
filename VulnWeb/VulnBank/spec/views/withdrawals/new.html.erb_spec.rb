require 'rails_helper'

RSpec.describe "withdrawals/new", type: :view do
  before(:each) do
    assign(:withdrawal, Withdrawal.new(
      :user_id => 1,
      :admin_id => 1,
      :amount => 1.5,
      :status => "MyString"
    ))
  end

  it "renders new withdrawal form" do
    render

    assert_select "form[action=?][method=?]", withdrawals_path, "post" do

      assert_select "input#withdrawal_user_id[name=?]", "withdrawal[user_id]"

      assert_select "input#withdrawal_admin_id[name=?]", "withdrawal[admin_id]"

      assert_select "input#withdrawal_amount[name=?]", "withdrawal[amount]"

      assert_select "input#withdrawal_status[name=?]", "withdrawal[status]"
    end
  end
end
