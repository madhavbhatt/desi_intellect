require 'rails_helper'

RSpec.describe "withdraws/show", type: :view do
  before(:each) do
    @withdraw = assign(:withdraw, Withdraw.create!(
      :user_id => 2,
      :amount => 3.5
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3.5/)
  end
end
