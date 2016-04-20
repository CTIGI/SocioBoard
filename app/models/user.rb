class User < ApplicationRecord
  devise :omniauthable
  has_and_belongs_to_many :roles
  has_many :simulations

  def self.find_or_create_for_ctigi_auth_oauth(oauth_data)
    user = where(ctigi_auth_uid: oauth_data.uid).first_or_initialize
    user.email = oauth_data.info.email
    user.ctigi_auth_access_token = oauth_data.credentials.token
    user.save

    return user
  end

  def admin?
    act_as?("admin:admin")
  end

  private

  def act_as?(role)
    self.roles.select(:activities).distinct.map(&:activities).flatten.include?(role)
  end
end
