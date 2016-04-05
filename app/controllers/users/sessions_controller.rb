class Users::SessionsController < Devise::SessionsController
  def destroy
    super
    cookies.clear(:domain => :all)
  end
end
