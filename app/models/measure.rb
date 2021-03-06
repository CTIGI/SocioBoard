class Measure < ApplicationRecord
  belongs_to :offender
  scope :nears_due_date,       -> { where("end_date_measure > ? AND end_date_measure < ? AND measure_type = ?", Date.today, Date.today + 10, I18n.t("activerecord.attributes.offender.measure_type_list.provisional_admission")) }
  scope :near_current_periods, -> { where("current_period_date <= ?", Date.today + 30) }
  scope :overdues,             -> { where("end_date_measure < ? AND measure_type = ?", Date.today,  I18n.t("activerecord.attributes.offender.measure_type_list.provisional_admission")) }
  scope :sanctions,            -> { where("end_date_measure <= ? AND  measure_type = ?", Date.today + 10, I18n.t("activerecord.attributes.offender.measure_type_list.sanction")) }

  def self.render_data_list(field)
    data = [[I18n.t("app.no_record"), I18n.t("app.no_record")]]
    self.pluck(field).each do |field_name|
      data << [field_name, field_name] unless data.include?([field_name, field_name]) || field_name.blank? || field_name == I18n.t("app.no_record")
    end
    data
  end
end
