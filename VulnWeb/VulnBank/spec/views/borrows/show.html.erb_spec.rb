require 'rails_helper'

RSpec.describe "borrows/show", type: :view do
  before(:each) do
    @borrow = assign(:borrow, Borrow.create!(
      :from => "From",
      :to => "To",
      :admin_id => 2,
      :status => "Status",
      :amount => 3.5
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/From/)
    expect(rendered).to match(/To/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Status/)
    expect(rendered).to match(/3.5/)
  end
end
