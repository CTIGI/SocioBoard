class Offender < ApplicationRecord
  paginates_per 10
  belongs_to :unit
  has_many :measures, dependent: :destroy
  has_and_belongs_to_many :crimes, -> { distinct }
  scope :duplicated, -> { where(duplicated: true) }
  scope :not_evaded, -> { where(evaded: false) }
  scope :evaded, -> { where(evaded: true) }

  scope :nears_due_date,       -> { joins(:measures).where("measures.end_date_measure > ? AND measures.end_date_measure < ? AND measures.measure_type = ?", Date.today, Date.today + 10, I18n.t("activerecord.attributes.offender.measure_type_list.provisional_admission")) }
  scope :near_current_periods, -> { joins(:measures).where("measures.current_period_date <= ?", Date.today + 30) }
  scope :overdues,             -> { joins(:measures).where("measures.end_date_measure < ? AND measures.measure_type = ?", Date.today,  I18n.t("activerecord.attributes.offender.measure_type_list.provisional_admission")) }
  scope :sanctions,            -> { joins(:measures).where("measures.end_date_measure <= ? AND  measures.measure_type = ?", Date.today + 10, I18n.t("activerecord.attributes.offender.measure_type_list.sanction")) }


  def self.crimes_list
    all_crimes_list = []
    self.order(:crimes).pluck("crimes").each do |crimes|
      crimes.each do |c|
        all_crimes_list << [c, c] unless all_crimes_list.include?([c, c])
      end
    end

    all_crimes_list.sort
  end

  def self.render_data_list(field)
    data = [[I18n.t("app.no_record"), I18n.t("app.no_record")]]
    self.pluck(field).each do |field_name|
      data << [field_name, field_name] unless data.include?([field_name, field_name]) || field_name.blank? || field_name == I18n.t("app.no_record")
    end
    data
  end

  ransacker :scope_units do
    Arel::Nodes::SqlLiteral.new "offenders.unit_id"
  end

end
