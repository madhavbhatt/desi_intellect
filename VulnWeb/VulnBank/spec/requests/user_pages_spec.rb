require 'spec_helper'

describe 'User pages' do
  subject { page }

  describe 'signup page' do
    before { visit signup_path }
    it { should have_selector('h1', text: 'Sign up') }
    it { should have_selector('title', text: 'Sign up')}
  end
  describe 'profile page' do
    # Code to make a user variable
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }
    it { should have_selector('h1',    text: user.name) }
    it { should have_selector('title', text: user.name) }
  end
  describe 'signup' do
    before { visit signup_path }
    let(:submit) { 'Create my account' }
    describe 'with invalid information' do
      it 'should not create a user' do
        expect { click_button submit }.not_to change(User, :count)
      end
    end
    describe 'with valid information' do
      before do
        fill_in 'Name', with: 'Example User'
        fill_in 'Email', with: 'user@example.com'
        fill_in 'Password', with: 'foobar'
        fill_in 'Confirmation', with: 'foobar'
      end
    end
    it 'should create a user' do
      expect { click_button submit }.to change(User, :count).by(1)
    end
  end
  describe 'edit' do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end
    before { visit edit_user_path(user) }
    describe 'page' do
      it { should have_selector('h1', text: 'Update your profile') }
      it { should have_selector('title', text: 'Edit user') }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end
    describe 'with invalid information' do
      before { click_button 'Save changes' }
    end
    it { should have_content('error') }
    describe 'with valid information' do
      let(:new_name) { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in 'Name', with: new_name
        fill_in 'Email', with: new_email
        fill_in 'Password', with: user.password
        fill_in 'Confirmation', with: user.password
        click_button 'save changes'
      end
    end
  end
  describe 'index' do
    before(:each) do
      sign_in user
      visit users_path
    end
    before do
      sign_in FactoryGirl.create(:user)
      FactoryGirl.create(:user, name: 'Bob', email: 'bob@example.com')
      FactoryGirl.create(:user, name: 'Ben', email: 'ben@example.com')
      visit users_path
    end
    it { should have selector('title', text: 'All users') }
    it { should have selector('h1', text: 'All users') }
    it 'should list each user' do
      User.all.each do |user|
        page.should have_selector('li', text: user.name)
      end
    end
    describe 'pagination' do
      it { should have_selector('div.pagination') }
      it 'should list each user' do
        User.paginate(page: 1).each do |user|
          page.should have_selector('li', text: user.name)
        end
      end
    end
    describe 'delete links' do
      it { should_not have_link('delete') }
      describe 'as an admin user' do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end
        it { should have_link('delete', href: user_path(User.first)) }
        it 'should be able to delete another user' do
          expect { click_link('delete') }.to change(User, :count).by(-1)
        end
        it { should_not have_link('delete', href: user_path(admin)) }
      end
    end
  end
end


