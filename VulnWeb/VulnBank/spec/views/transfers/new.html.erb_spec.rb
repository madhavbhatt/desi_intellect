require 'rails_helper'

RSpec.describe "transfers/new", type: :view do
  before(:each) do
    assign(:transfer, Transfer.new(
      :from => "MyString",
      :to => "MyString",
      :amount => 1.5
    ))
  end

  it "renders new transfer form" do
    render

    assert_select "form[action=?][method=?]", transfers_path, "post" do

      assert_select "input#transfer_from[name=?]", "transfer[from]"

      assert_select "input#transfer_to[name=?]", "transfer[to]"

      assert_select "input#transfer_amount[name=?]", "transfer[amount]"
    end
  end
end
