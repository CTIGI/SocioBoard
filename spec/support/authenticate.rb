module SpecHelpers
  module Authentication
    def sign_in(user = build_stubbed(:user))
      visit root_path
      click_link("submit-login")
    end
  end
end
