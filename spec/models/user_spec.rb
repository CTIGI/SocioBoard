require 'rails_helper'

RSpec.describe User, :type => :model do
  let(:user) { create(:user) }

  it "should have a factory" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  context "Associations" do
    it { should have_and_belong_to_many :roles }
  end

  context "Should Respond" do
    it { should respond_to(:email) }
    it { should respond_to(:ctigi_auth_uid) }
    it { should respond_to(:roles) }
    it { should respond_to(:ctigi_auth_access_token) }
    it { should respond_to(:created_at) }
    it { should respond_to(:updated_at) }
  end
end
