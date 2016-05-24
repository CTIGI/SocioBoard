class Unit < ApplicationRecord
  has_many :offenders
  has_many :unit_occupations
  has_and_belongs_to_many :measure_types

  geocoded_by :full_address

  validates :min_age, presence: true, numericality: { greater_than_or_equal_to: 12,
                                                      less_than_or_equal_to: 22 }
  validates :max_age, presence: true, numericality: { greater_than_or_equal_to: 12,
                                                      less_than_or_equal_to: 22 }

  validate  :check_ages

  def full_address
    "#{ street }, #{ county }"
  end

  def occupation_increased?(date)
    old_occupation = unit_occupations.where(day: date).first
    if old_occupation
      if offenders.not_evaded.count > old_occupation.occupation
        return true
      end
    else
      return true
    end

    return false
  end

  def occupation_variation(date)
    old_occupation = unit_occupations.where(day: date).first
    if old_occupation
      return offenders.not_evaded.count - old_occupation.occupation
    else
      return offenders.not_evaded.count
    end
  end

  def occupation_variation_percentage(date)
    total_offenders = offenders.not_evaded.count
    if total_offenders > 0
      (occupation_variation(date).to_f/total_offenders.to_f)*100
    else
      0
    end
  end

  def biggest_occupation
    unit_occupations.maximum("occupation")
  end

  def lowest_occupation
    unit_occupations.minimum("occupation")
  end

  def measure_type_names
    measure_types.map(&:name).join(",")
  end

  def offenders_out_of_profile_by_age
    offenders.not_evaded.where("age < ? OR age > ?", min_age, max_age).count
  end

  def inconsistences
    offenders.not_evaded.where("age < ? OR age > ?", 12, 20).count
  end

  def offenders_out_of_profile
    offenders_out_of_profile_by_age + offenders_out_of_measure
  end

  def offenders_out_of_profile_percentage
    ((offenders_out_of_profile.to_f/capacity.to_f)*(100)).round(2)
  end

  def count_applied_measure_by_age(age, measure_type)
    offenders.not_evaded.where(age: age).joins(:measures).where("measures.measure_type" => measure_type).count
  end

  def offenders_out_of_measure
    count = 0
    if !measure_type_names.include? 'Unidade de Internação'
      count += self.offenders.not_evaded.joins(:measures).where('measure_type = ?', 'Internação').count
    end

    if !measure_type_names.include? 'Unidade de semiliberdade'
      count += self.offenders.not_evaded.joins(:measures).where('measure_type = ?', 'SemiLiberdade').count
    end

    if !measure_type_names.include? 'Unidade de Internação Provisória'
      count += self.offenders.not_evaded.joins(:measures).where('measure_type = ?', 'Internação Provisória').count
    end
    if !measure_type_names.include? 'Unidade de Sanção'
      count += self.offenders.not_evaded.joins(:measures).where('measure_type = ?', 'Sanção').count
    end

    return count
  end

  def analysis_data_count
    ages_range = (12..20)
    total_conformities       = 0
    total_out_of_age         = 0
    total_out_of_measure     = 0
    total_age_and_measure    = 0
    ages_range.each do |age|
      measures = [ { measure: I18n.t("activerecord.attributes.offender.measure_type_list.provisional_admission"), unit_measure: "Unidade de Internação Provisória" },
                   { measure: I18n.t("activerecord.attributes.offender.measure_type_list.admission"), unit_measure: "Unidade de Internação"},
                   { measure: I18n.t("activerecord.attributes.offender.measure_type_list.sanction"), unit_measure: "Unidade de Sanção"} ]

      measures.each do |measure|
        if age.between?(min_age, max_age) && measure_type_names.include?(measure[:unit_measure])
          total_conformities += self.count_applied_measure_by_age(age, measure[:measure])
        elsif self.measure_types.map(&:name).include?(measure[:unit_measure])
          total_out_of_age += self.count_applied_measure_by_age(age, measure[:measure])
        elsif age.between?(min_age, max_age)
          total_out_of_measure += self.count_applied_measure_by_age(age, measure[:measure])
        else
          total_age_and_measure += self.count_applied_measure_by_age(age, measure[:measure])
        end
      end
    end
    [ total_out_of_measure, total_out_of_age, total_age_and_measure, total_conformities ]
  end

  private

  def check_ages
    if max_age < min_age
      error_string = I18n.t("activerecord.errors.models.attributes.unit.min_age_bigger_than_max")
      errors.add(:max_age, error_string)
    end
  end

end
