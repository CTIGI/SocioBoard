module AnalysisHelper
  def show_table_unconformities_value(age_value, min_age, max_age, measure_value)
    td_class = ""

    if measure_value > 0
      if age_value.between?(min_age, max_age)
        td_class = "table-blue-rowspan text-center"
      else
        td_class = "table-red-rowspan text-center"
      end
    end

    content_tag(:td, class: td_class) do
      concat( measure_value ) if measure_value > 0
    end
  end
end
