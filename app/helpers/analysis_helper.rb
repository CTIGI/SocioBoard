module AnalysisHelper
  def show_inconsistences(unit_id, inconsistences_value)
    td_class = ""
    if inconsistences_value > 0
      td_class = "table-light-blue-rowspan text-center"
    end

    content_tag(:td, class: td_class) do
      if inconsistences_value > 0
        link_to "#", class: "index-object link-index-black", data: { link: modal_index_offenders_path(unit_id: unit_id ) } do
          concat(inconsistences_value)
        end
      end
    end
  end

  def show_table_unconformities_value(age_value, min_age, max_age, measure_value, unit_id, measure_type, unit_measure, is_simulator)
    td_class = ""

    link = is_simulator ? load_simulator_modal_analysis_index_path(offenders_amount: measure_value, origin_unit: unit_id, age: age_value, measure_type: truncate_words(measure_type), unit_measure: unit_measure) : modal_index_offenders_path(q:
            { age_eq: age_value, unit_id_eq: unit_id, measures_measure_type_in: measure_type})

    unit = Unit.find(unit_id)
    unit_measures = unit.measure_type_names

    if measure_value > 0
      if age_value.between?(min_age, max_age) && (unit_measures.include?(unit_measure))
        td_class = "table-blue-rowspan text-center"
      elsif unit.measure_types.map(&:name).include?(unit_measure)
        td_class = "table-yellow-rowspan text-center"
      elsif age_value.between?(min_age, max_age)
        td_class = "table-red-rowspan text-center"
      else
        td_class = "table-orange-rowspan text-center"
      end
    end

    content_tag(:td, class: td_class, id: "#{unit_id}-#{truncate_words(measure_type)}-#{age_value}") do
      if measure_value > 0
        link_to "#", class: "index-object btn-edit-object link-index-black", data: { link: link } do
          concat(content_tag(:span, measure_value))
        end
      end
    end

  end
end
