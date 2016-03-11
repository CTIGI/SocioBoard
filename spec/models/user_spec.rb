require 'rails_helper'

RSpec.describe User, :type => :model do
  let(:user) { create(:user) }

  it "should have a factory" do
    expect(FactoryGirl.build(:user)).to be_valid
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

  context "Class Methods" do
    describe "find_or_create_for_ctigi_auth_oauth" do

      let (:oauth_data) { oauth_data = OmniAuth::AuthHash.new({ provider: "ctigi_auth",
                                                                     uid: "1",
                                                                    info: { email: "test@example.com" },
                                                                    credentials: { token: "123456" }
                                                             })}
      it "Should save a new user" do
        user = User.find_or_create_for_ctigi_auth_oauth(oauth_data)
        expect(user.persisted?).to eq true
      end
    end
  end
end
