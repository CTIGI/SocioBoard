require "rails_helper"

RSpec.describe Users::OmniauthCallbacksController, type: :controller do
  describe "ctigi_auth" do
    let(:user) { create(:user) }

    before do
      request.env["devise.mapping"] = Devise.mappings[:user]
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:ctigi_auth]
    end

    it "Should authenticate the user" do
      expect(User).to receive(:find_or_create_for_ctigi_auth_oauth).and_return(user)
      get :ctigi_auth
      expect(response).to be_redirect
      expect(flash[:notice]).to be_present
    end
  end
end
