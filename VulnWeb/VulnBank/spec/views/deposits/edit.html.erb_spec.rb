require 'rails_helper'

RSpec.describe "deposits/edit", type: :view do
  before(:each) do
    @deposit = assign(:deposit, Deposit.create!(
      :user_id => 1,
      :admin_id => 1,
      :amount => 1.5,
      :status => "MyString"
    ))
  end

  it "renders the edit deposit form" do
    render

    assert_select "form[action=?][method=?]", deposit_path(@deposit), "post" do

      assert_select "input#deposit_user_id[name=?]", "deposit[user_id]"

      assert_select "input#deposit_admin_id[name=?]", "deposit[admin_id]"

      assert_select "input#deposit_amount[name=?]", "deposit[amount]"

      assert_select "input#deposit_status[name=?]", "deposit[status]"
    end
  end
end
