class Measure < ApplicationRecord
  belongs_to :offender
  scope :nears_due_date,       -> { where(near_due_date: true) }
  scope :near_current_periods, -> { where("current_period_date <= ?", Date.today + 30) }

  def self.render_data_list(field)
    data = [[I18n.t("app.no_record"), I18n.t("app.no_record")]]
    self.pluck(field).each do |field_name|
      data << [field_name, field_name] unless data.include?([field_name, field_name]) || field_name.blank? || field_name == I18n.t("app.no_record")
    end
    data
  end
end
