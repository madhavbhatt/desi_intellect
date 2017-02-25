require 'rails_helper'

RSpec.describe "deposits/new", type: :view do
  before(:each) do
    assign(:deposit, Deposit.new(
      :user_id => 1,
      :admin_id => 1,
      :amount => 1.5,
      :status => "MyString"
    ))
  end

  it "renders new deposit form" do
    render

    assert_select "form[action=?][method=?]", deposits_path, "post" do

      assert_select "input#deposit_user_id[name=?]", "deposit[user_id]"

      assert_select "input#deposit_admin_id[name=?]", "deposit[admin_id]"

      assert_select "input#deposit_amount[name=?]", "deposit[amount]"

      assert_select "input#deposit_status[name=?]", "deposit[status]"
    end
  end
end
