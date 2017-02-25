require 'rails_helper'

RSpec.describe "borrows/edit", type: :view do
  before(:each) do
    @borrow = assign(:borrow, Borrow.create!(
      :from => "MyString",
      :to => "MyString",
      :admin_id => 1,
      :status => "MyString",
      :amount => 1.5
    ))
  end

  it "renders the edit borrow form" do
    render

    assert_select "form[action=?][method=?]", borrow_path(@borrow), "post" do

      assert_select "input#borrow_from[name=?]", "borrow[from]"

      assert_select "input#borrow_to[name=?]", "borrow[to]"

      assert_select "input#borrow_admin_id[name=?]", "borrow[admin_id]"

      assert_select "input#borrow_status[name=?]", "borrow[status]"

      assert_select "input#borrow_amount[name=?]", "borrow[amount]"
    end
  end
end
