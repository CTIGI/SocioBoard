module UnitHelper
  def age_range(min, max)
    return "#{min} - #{max}"
  end

  def initials_measure_unit_type(type)
    unless type.blank?
      initials = []
      type.each do |tu|
        case tu
        when I18n.t("measure_units_types.free_range_unit")
          initials << t("views.indicators.units.free_range_unit_initial")
        when I18n.t("measure_units_types.admission_unit")
          initials << t("views.indicators.units.admission_unit_initial")
        when I18n.t("measure_units_types.provisional_admission_unit")
          initials << t("views.indicators.units.provisional_admission_unit_initial")
        end
      end

      initials.join(", ")
    end
  end
end
