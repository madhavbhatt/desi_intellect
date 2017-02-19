require 'spec helper'
describe 'Authentication' do
      describe 'signin' do
        before { visit signin_path }
        describe 'with invalid information' do
          before { click button 'Sign in' }
          it { should have_selector('title', text: 'Sign in') }
          it { should have_selector('div.alert.alert-error', text: 'Invalid') }
        end
        describe "with valid information" do
          let(:user) { FactoryGirl.create(:user) }
          before do
            fill_in 'Email', with: user.email
            fill_in 'Password', with: user.password
            click_button 'Sign in'
          end
          describe 'followed by signout' do
            before { click_link 'Sign out' }
            it { should have_link('Sign in') }
          end

          it { should have_selector('title', text:user_name) }
          it { should have_link('Profile', href:user_path(user))}
          it { should have_link('Sign out', href:signout_path)}
          it { should have_link('Sign in', href: signin_path)}
        end

        describe 'after visiting another page' do
          before { click_link 'Home' }
          it { should_not have_selector('div.alert.alert-error') }
        end
      end
end

