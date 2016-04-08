class Unit < ApplicationRecord
  extend Enumerize

  has_many :offenders
  has_and_belongs_to_many :measure_types

  validates :min_age, presence: true, numericality: { greater_than_or_equal_to: 12,
                                                      less_than_or_equal_to: 22 }
  validates :max_age, presence: true, numericality: { greater_than_or_equal_to: 12,
                                                      less_than_or_equal_to: 22 }

  validate  :check_ages

  def measure_type_names
    measure_types.map(&:name).join(",")
  end

  def offenders_out_of_profile_by_age
    offenders.where("age < ? OR age > ?", min_age, max_age).count
  end

  def inconsistences
    offenders.where("age < ? OR age > ?", 12, 20).count
  end

  def offenders_out_of_profile_percentage
    ((offenders_out_of_profile_by_age.to_f/capacity.to_f)*(100)).round(2)
  end

  def count_applied_measure_by_age(age, measure_type)
    offenders.where(age: age).joins(:measures).where("measures.measure_type" => measure_type).count
  end

  def offenders_out_of_measure
    count = 0
    if !measure_type_names.include? 'Unidade de Internação'
      count += self.offenders.joins(:measures).where('measure_type = ?', 'Internação').count
    end

    if !measure_type_names.include? 'Unidade de semiliberdade'
      count += self.offenders.joins(:measures).where('measure_type = ?', 'SemiLiberdade').count
    end

    if !measure_type_names.include? 'Unidade de Internação Provisória'
      count += self.offenders.joins(:measures).where('measure_type = ?', 'Internação Provisória').count
    end
    if !measure_type_names.include? 'Unidade de Sanção'
      count += self.offenders.joins(:measures).where('measure_type = ?', 'Sanção').count
    end
    
    return count
  end

  private

  def check_ages
    if max_age < min_age
      error_string = I18n.t("activerecord.errors.models.attributes.unit.min_age_bigger_than_max")
      errors.add(:max_age, error_string)
    end
  end

end
