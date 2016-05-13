module HomeHelper
  def render_center_data(unit, animation)
    unless unit.blank?
      days_forward = Date.today + 30

      provisional_admission = I18n.t("activerecord.attributes.offender.measure_type_list.provisional_admission")
      near_provisional_admission_date = Measure.where("end_date_measure < ? and measure_type = ?", days_forward, provisional_admission)
                                               .joins(:offender).where("offenders.unit_id = ? AND offenders.evaded = ?", unit.id, false).count

      admission = I18n.t("activerecord.attributes.offender.measure_type_list.admission")
      near_admission_date =  Measure.where("end_date_measure < ? and measure_type = ?", days_forward, admission)
                                               .joins(:offender).where("offenders.unit_id = ?AND offenders.evaded = ?", unit.id, false).count

      render partial: "indicators/partials/unit_info", locals: { id: unit.id,
                                                       animation: animation,
                                                       name: unit.name,
                                                       unit_type: unit.measure_types.pluck(:name),
                                                       range_date: "#{unit.min_age} - #{unit.max_age}",
                                                       capacity: unit.capacity,
                                                       occupied: unit.occupied,
                                                       near_provisional_admission_date: near_provisional_admission_date,
                                                       near_admission_date: near_admission_date,
                                                       offenders_out_of_profile: unit.offenders_out_of_profile_by_age,
                                                       offenders_out_of_measure: unit.offenders_out_of_measure }
    end
  end

  def underflow(capacity, occupied)
    total = (capacity - occupied)
    percentage = ((total.abs * 100)/capacity).round(2)
    total > 0 ? [0, ""] : ["#{total.abs} (#{percentage}%)", "danger-item"]
  end

  def render_admission_data(near_admission_date, markup = "warning-item")
    near_admission_date > 0 ? [near_admission_date, markup] : [ 0, "" ]
  end

  def randomEntrance
     animation = ["fadeInRight", "fadeInLeft", "fadeInUp", "fadeInDown"].sample
    "animated #{animation}"
  end
end
