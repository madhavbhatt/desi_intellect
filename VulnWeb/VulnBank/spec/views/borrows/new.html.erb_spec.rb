require 'rails_helper'

RSpec.describe "borrows/new", type: :view do
  before(:each) do
    assign(:borrow, Borrow.new(
      :from => "MyString",
      :to => "MyString",
      :admin_id => 1,
      :status => "MyString",
      :amount => 1.5
    ))
  end

  it "renders new borrow form" do
    render

    assert_select "form[action=?][method=?]", borrows_path, "post" do

      assert_select "input#borrow_from[name=?]", "borrow[from]"

      assert_select "input#borrow_to[name=?]", "borrow[to]"

      assert_select "input#borrow_admin_id[name=?]", "borrow[admin_id]"

      assert_select "input#borrow_status[name=?]", "borrow[status]"

      assert_select "input#borrow_amount[name=?]", "borrow[amount]"
    end
  end
end
