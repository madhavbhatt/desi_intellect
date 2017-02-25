require 'rails_helper'

RSpec.describe "transfers/edit", type: :view do
  before(:each) do
    @transfer = assign(:transfer, Transfer.create!(
      :from => "MyString",
      :to => "MyString",
      :amount => 1.5
    ))
  end

  it "renders the edit transfer form" do
    render

    assert_select "form[action=?][method=?]", transfer_path(@transfer), "post" do

      assert_select "input#transfer_from[name=?]", "transfer[from]"

      assert_select "input#transfer_to[name=?]", "transfer[to]"

      assert_select "input#transfer_amount[name=?]", "transfer[amount]"
    end
  end
end
