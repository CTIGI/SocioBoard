class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def after_omniauth_failure_path_for(*)
    root_path
  end

  def ctigi_auth
    begin
      oauth_data = request.env["omniauth.auth"]
      @user = User.find_or_create_for_ctigi_auth_oauth(oauth_data)
      if @user.persisted?
        set_flash_message(:notice, :success, kind: "ctigi_auth")
        sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
      else
        redirect_to root_path
      end
    rescue
      redirect_to root_path
    end
  end
end
