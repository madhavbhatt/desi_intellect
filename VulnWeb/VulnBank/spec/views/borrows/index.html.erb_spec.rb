require 'rails_helper'

RSpec.describe "borrows/index", type: :view do
  before(:each) do
    assign(:borrows, [
      Borrow.create!(
        :from => "From",
        :to => "To",
        :admin_id => 2,
        :status => "Status",
        :amount => 3.5
      ),
      Borrow.create!(
        :from => "From",
        :to => "To",
        :admin_id => 2,
        :status => "Status",
        :amount => 3.5
      )
    ])
  end

  it "renders a list of borrows" do
    render
    assert_select "tr>td", :text => "From".to_s, :count => 2
    assert_select "tr>td", :text => "To".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
    assert_select "tr>td", :text => 3.5.to_s, :count => 2
  end
end
