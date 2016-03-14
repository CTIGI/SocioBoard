module SpecHelpers
  module ControllerHelpers
    def sign_in_mock_user(user = build_stubbed(:user))
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
    end
  end
end
