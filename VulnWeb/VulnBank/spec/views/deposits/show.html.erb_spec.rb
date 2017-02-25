require 'rails_helper'

RSpec.describe "deposits/show", type: :view do
  before(:each) do
    @deposit = assign(:deposit, Deposit.create!(
      :user_id => 2,
      :admin_id => 3,
      :amount => 4.5,
      :status => "Status"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4.5/)
    expect(rendered).to match(/Status/)
  end
end
