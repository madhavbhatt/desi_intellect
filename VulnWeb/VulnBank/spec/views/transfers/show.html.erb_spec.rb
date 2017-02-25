require 'rails_helper'

RSpec.describe "transfers/show", type: :view do
  before(:each) do
    @transfer = assign(:transfer, Transfer.create!(
      :from => "From",
      :to => "To",
      :amount => 2.5
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/From/)
    expect(rendered).to match(/To/)
    expect(rendered).to match(/2.5/)
  end
end
