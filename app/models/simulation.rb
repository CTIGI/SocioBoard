class Simulation < ApplicationRecord
  belongs_to :user

  def generate_name
    self.name = I18n.t("activerecord.functions.simulation.auto_generated_name", date: I18n.l(DateTime.now, format: :short))
  end
end
