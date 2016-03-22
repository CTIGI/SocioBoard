module AnalysisHelper
  def show_inconsistences(unit_id, inconsistences_value)
    td_class = ""
    if inconsistences_value > 0
      td_class = "table-red-rowspan text-center"
    end

    content_tag(:td, class: td_class) do
      if inconsistences_value > 0
        link_to "#", class: "index-object link-index", data: { link: modal_index_offenders_path(q:
                { age_lt: 12, age_qt: 20, unit_id_eq: unit_id}) } do
          concat(inconsistences_value)
        end
      end
    end
  end

  def show_table_unconformities_value(age_value, min_age, max_age, measure_value, unit_id, measure_type)
    td_class = ""

    if measure_value > 0
      if age_value.between?(min_age, max_age)
        td_class = "table-blue-rowspan text-center"
      else
        td_class = "table-red-rowspan text-center"
      end
    end

    content_tag(:td, class: td_class) do
      if measure_value > 0
        link_to "#", class: "index-object link-index", data: { link: modal_index_offenders_path(q:
                { age_eq: age_value, unit_id_eq: unit_id, measures_measure_type_in: measure_type}) } do
          concat(measure_value)
        end
      end
    end

  end
end
