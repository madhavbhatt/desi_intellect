require 'spec_helper'
describe Micropost do
  let(:user) { FactoryGirl.create(:user) }
  before do
# This code is wrong!
    @micropost = Micropost.new(content: "Lorem ipsum", user_id: user.id)
  end
  subject { @micropost }
  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }

  it { should be_valid }

  describe 'when user id is not present' do
    before { @micropost.user_id = nil }
    it { should_not be_valid }
  end

  describe 'accessible attributes' do
    it 'should not allow access to user id' do
      expect do
        Micropost.new(user_id: user.id)
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe 'when user id is not present' do
    before { @micropost.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank content" do
    before { @micropost.content = " " }
    it { should_not be_valid }
  end
  describe "with content that is too long" do
    before { @micropost.content = "a" * 141 }
    it { should_not be_valid }
  end
end
