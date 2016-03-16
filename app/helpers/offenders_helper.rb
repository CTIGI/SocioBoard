module OffendersHelper

  def colorize_table_row(offender)
    if near_due_date?(measure_data(offender, :measure_type), measure_data(offender, :end_date_measure))
      "near_due_date"
    elsif near_current_period?(measure_data(offender, :current_period_date))
      "near_current_period"
    elsif overdue_measure?(measure_data(offender, :measure_type), measure_data(offender, :end_date_measure))
      "overdue_measure"
    else
      ""
    end
  end

  def near_current_period?(current_period_date)
    if current_period_date.blank?
      false
    else
      current_period_date.to_date <= Date.today + 30.days
    end
  end

  def near_due_date?(measure_type, end_date_measure)
    provisional_admission  = I18n.t("activerecord.attributes.offender.measure_type_list.provisional_admission")
    diff_days = (end_date_measure.to_date - Date.today).to_i
    ( (diff_days <= 10 && diff_days >= 0) && measure_type.include?(provisional_admission) )
  end

  def overdue_measure?(measure_type, end_date_measure)
    ( end_date_measure.to_date < Date.today ) && measure_type == I18n.t("activerecord.attributes.offender.measure_type_list.provisional_admission")
  end

  def display_offender_name(name, user)
    if user.admin?
      name
    else
      I18n.t("views.offenders.confidential")
    end
  end

  def truncate_words(word)
    word.gsub!("CENTRO", "C.")
    word.gsub!("SOCIOEDUCATIVO", "SOCIOED.")
    word.gsub!("EDUCACIONAL", "ED.")
    word.gsub!("UNIDADE", "UN.")
    word.gsub!("INTERNAÇÃO", "INT.")
    word.gsub!("PROVISÓRIA", "PROV.")
    word.gsub!("SEMILIBERDADE", "SEMILIB.")
    word.gsub!("SEMILIBERDADE", "SEMILIB.")
    word.gsub!("ALOISIO", "AL.")
    word.gsub!("ZEQUINHA", "ZEQ.")
    word.gsub!("BARBOSA", "B.")
    word.gsub!("FRANCISCO", "FCO.")
    word
  end

  def measure_data(offender, field)
    result = []
    if offender.measures.blank?
      result << show_field(offender.measures)
    else
      offender.measures.each do |off|
        result << off.send(field).to_s
      end
    end
    result.delete("")
    result.size > 1 ? result.join(", ") : result[0]
  end

  def generate_preview_numbers(counters)
    unless counters.blank?
      result = ""
      counters.each do |c|
        value = c.has_key?(:percentage) ? "#{c.values[0]} (#{c[:percentage]})" : c.values[0]
        result << (
          content_tag(:div, class: "col-sm-2 col-xs-6") do
            concat(
              content_tag(:div, class: "cb-item") do
                concat(
                  content_tag(:small, c.keys[0])
                )
                concat(
                  content_tag(:h3, value)
                )
              end
            )
          end
        )
      end
      raw result
    end
  end

  def period_label(offender)
    unless measure_data(offender, :current_period).blank?
      content_tag(:b) do
        concat(
          t("views.offenders.filter_panel.current_period", period: measure_data(offender, :current_period))
        )
        concat(tag(:br))
      end
    end
  end
end
