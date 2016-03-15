class Unit < ApplicationRecord
  has_many :offenders

  validates :min_age, presence: true, numericality: { greater_than_or_equal_to: 12,
                                                      less_than_or_equal_to: 22 }
  validates :max_age, presence: true, numericality: { greater_than_or_equal_to: 12,
                                                      less_than_or_equal_to: 22 }

  validate  :check_ages

  enum measure_unit_type: {
    free_range_unit: 1,
    admission_unit: 2,
    provisional_admission_unit: 3
  }

  def offenders_out_of_profile
    offenders.where("age <= ? OR age >= ?", min_age, max_age).count
  end

  def offenders_out_of_profile_percentage
    ((offenders_out_of_profile.to_f/capacity.to_f)*(100)).round(2)
  end

  def count_applied_measure_by_age(age, measure_type)
    offenders.where(age: age).joins(:measures).where("measures.measure_type" => measure_type).count
  end

  def offenders_out_of_measure
    if measure_unit_type.blank?
      0
    else
      measure_type = measure_unit_type_i18n.gsub("Unidade de ", "").downcase
      offenders.joins(:measures).where('lower(measure_type) <> ?', measure_type).count
    end
  end

  private

  def check_ages
    if max_age < min_age
      error_string = I18n.t("activerecord.errors.models.attributes.unit.min_age_bigger_than_max")
      errors.add(:max_age, error_string)
    end
  end

end
