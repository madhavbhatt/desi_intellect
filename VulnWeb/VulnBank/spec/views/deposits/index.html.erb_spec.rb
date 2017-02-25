require 'rails_helper'

RSpec.describe "deposits/index", type: :view do
  before(:each) do
    assign(:deposits, [
      Deposit.create!(
        :user_id => 2,
        :admin_id => 3,
        :amount => 4.5,
        :status => "Status"
      ),
      Deposit.create!(
        :user_id => 2,
        :admin_id => 3,
        :amount => 4.5,
        :status => "Status"
      )
    ])
  end

  it "renders a list of deposits" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.5.to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
  end
end
