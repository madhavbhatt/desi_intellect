require 'rails_helper'

RSpec.describe "transfers/index", type: :view do
  before(:each) do
    assign(:transfers, [
      Transfer.create!(
        :from => "From",
        :to => "To",
        :amount => 2.5
      ),
      Transfer.create!(
        :from => "From",
        :to => "To",
        :amount => 2.5
      )
    ])
  end

  it "renders a list of transfers" do
    render
    assert_select "tr>td", :text => "From".to_s, :count => 2
    assert_select "tr>td", :text => "To".to_s, :count => 2
    assert_select "tr>td", :text => 2.5.to_s, :count => 2
  end
end
