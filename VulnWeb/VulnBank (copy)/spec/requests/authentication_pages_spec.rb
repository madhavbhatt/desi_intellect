require 'spec helper'
describe 'Authentication' do
      describe 'signin' do
        before { visit signin_path }
        describe 'with invalid information' do
          before { click_button 'Sign in' }
          it { should have_selector('title', text: 'Sign in') }
          it { should have_selector('div.alert.alert-error', text: 'Invalid') }
        end
        describe 'with valid information' do
          let(:user) { FactoryGirl.create(:user) }
          before { sign_in user } do
            fill_in 'Email', with: user.email
            fill_in 'Password', with: user.password
            click_button 'Sign in'
          end
          describe 'followed by signout' do
            before { click_link 'Sign out' }
            it { should have_link('Sign in') }
          end
          it { should have_selector('title', text:user.name) }
          it { should have_link('Users', href:users_path) }
          it { should have_link('Profile', href:user_path(user))}
          it { should have_link('settings', href:edit_user_path(user))}
          it { should have_link('Sign out', href:signout_path)}
          it { should have_link('Sign in', href: signin_path)}
        end
        describe 'after visiting another page' do
          before { click_link 'Home' }
          it { should_not have_selector('div.alert.alert-error') }
        end
      end
      describe 'authorization' do
        describe 'for non-signed-in users' do
          let(:user) { FactoryGirl.create(:user) }
          describe 'in the Users controller' do
            describe 'visiting the user index' do
              before { visit users_path }
              it { should have_selector('title', text: 'Sign in') }
            end
            describe 'visiting the edit page' do
              before { visit edit_user_path(user) }
              it { should have_selector('title', text: 'Sign in') }
            end
            describe 'submitting to the update action' do
              before { put user_path(user) }
              specify { response.should redirect_to(signin_path) }
            end
          end
          describe 'when attempting to visit a protected page' do
            before do
              visit edit_user_path(user)
              fill_in 'Email', with: user.email
              fill_in 'Password', with: user.password
              click_button 'Sign in'
            end
            describe 'after signing in' do
              it 'should render the desired protected page' do
                page.should have_selector('title', text: 'Edit user')
              end
            end
          end
        end
      end
end


