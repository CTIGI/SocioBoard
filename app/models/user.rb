class User < ApplicationRecord
  devise :database_authenticatable, :recoverable,
         :rememberable, :trackable, :validatable, :timeoutable

  has_and_belongs_to_many :roles
  has_many :simulations

  def admin?
    act_as?("admin:admin")
  end

  private

  def act_as?(role)
    self.roles.select(:activities).distinct.map(&:activities).flatten.include?(role)
  end
end
