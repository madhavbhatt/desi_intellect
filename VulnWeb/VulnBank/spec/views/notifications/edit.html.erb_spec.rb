require 'rails_helper'

RSpec.describe "notifications/edit", type: :view do
  before(:each) do
    @notification = assign(:notification, Notification.create!(
      :user => nil,
      :subscribed_user => nil,
      :post => nil,
      :identifier => 1,
      :type => "",
      :read => false
    ))
  end

  it "renders the edit notification form" do
    render

    assert_select "form[action=?][method=?]", notification_path(@notification), "post" do

      assert_select "input#notification_user_id[name=?]", "notification[user_id]"

      assert_select "input#notification_subscribed_user_id[name=?]", "notification[subscribed_user_id]"

      assert_select "input#notification_post_id[name=?]", "notification[post_id]"

      assert_select "input#notification_identifier[name=?]", "notification[identifier]"

      assert_select "input#notification_type[name=?]", "notification[type]"

      assert_select "input#notification_read[name=?]", "notification[read]"
    end
  end
end
