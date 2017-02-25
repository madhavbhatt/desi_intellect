require 'rails_helper'

RSpec.describe "withdraws/index", type: :view do
  before(:each) do
    assign(:withdraws, [
      Withdraw.create!(
        :user_id => 2,
        :amount => 3.5
      ),
      Withdraw.create!(
        :user_id => 2,
        :amount => 3.5
      )
    ])
  end

  it "renders a list of withdraws" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.5.to_s, :count => 2
  end
end
