require 'spec helper'
describe "Static pages" do
  subject { page }
  describe "Home page" do
        describe "for signed-in users" do
          let(:user) { FactoryGirl.create(:user) }
          before do
            FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
            FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
            sign_in user
            visit root_path
          end
          it "should render the user's feed" do
            user.feed.each do |item|
              page.should have_selector("li##{item.id}", text: item.content)
            end
          end
        end
  end
end
