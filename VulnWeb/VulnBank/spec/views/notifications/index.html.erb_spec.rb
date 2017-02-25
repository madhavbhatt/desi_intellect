require 'rails_helper'

RSpec.describe "notifications/index", type: :view do
  before(:each) do
    assign(:notifications, [
      Notification.create!(
        :user => nil,
        :subscribed_user => nil,
        :post => nil,
        :identifier => 2,
        :type => "Type",
        :read => false
      ),
      Notification.create!(
        :user => nil,
        :subscribed_user => nil,
        :post => nil,
        :identifier => 2,
        :type => "Type",
        :read => false
      )
    ])
  end

  it "renders a list of notifications" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Type".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
