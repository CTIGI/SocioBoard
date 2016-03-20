module UnitHelper
  def age_range(min, max)
    return "#{min} - #{max}"
  end

  def translate_measure_unit_type(type)
    I18n.t("enums.unit.measure_unit_type.#{type}") unless type.blank? 
  end
end
