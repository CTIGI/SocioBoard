module OffendersHelper

  def links_to_export
    links = ""
    attrs = { class: "export-file btn btn-success bg-white" }

    links << (
      content_tag :div do
        link_to "#", { id: "export_pdf",
                       data: {
                         link: generate_pdf_offenders_path, extension: ".pdf",
                         toggle: "tooltip",
                         placement: "top",
                         "original-title" => t("views.general.export.to_pdf")
                       } }.merge(attrs) do
          concat(fa_icon("file-pdf-o"))
        end
      end
    )

    links << (
      content_tag :div do
        link_to "#", { id: "export_sheet",
                       data: {
                         link: generate_sheet_offenders_path, extension: ".xlsx",
                         toggle: "tooltip",
                         placement: "top",
                         "original-title" => t("views.general.export.to_excel")
                       } }.merge(attrs) do
          concat(fa_icon("file-excel-o"))
        end
      end
    )
    raw links
  end

  def is_checked?(form_element, input)
    if params[form_element].present?
      params[form_element][input].present?
    else
      false
    end
  end

  def value_selected(form_element, input)
    if params[form_element].present?
      params[form_element][input]
    else
      [""]
    end
  end

  def colorize_table_row(offender)
    if near_due_date?(measure_data(offender, :measure_type), measure_data(offender, :end_date_measure))
      "near_due_date"
    elsif near_current_period?(measure_data(offender, :current_period_date))
      "near_current_period"
    elsif overdue_measure?(measure_data(offender, :measure_type), measure_data(offender, :end_date_measure))
      "overdue_measure"
    elsif sanction?(measure_data(offender, :measure_type), measure_data(offender, :end_date_measure))
      "sanction"
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
    unless end_date_measure == t("app.no_record")
      diff_days = (end_date_measure.to_date - Date.today).to_i
      ( (diff_days <= 10 && diff_days > 0) && measure_type.include?(provisional_admission) )
    end
  end

  def overdue_measure?(measure_type, end_date_measure)
    ( end_date_measure.to_date < Date.today ) && measure_type == I18n.t("activerecord.attributes.offender.measure_type_list.provisional_admission")
  end

  def sanction?(measure_type, end_date_measure)
    sanction  = I18n.t("activerecord.attributes.offender.measure_type_list.sanction")
    diff_days = (end_date_measure.to_date - Date.today).to_i
    ( (diff_days <= 10 ) && measure_type.include?(sanction) )
  end

  def display_offender_name(name, user)
    if user.admin?
      name
    else
      I18n.t("views.offenders.confidential")
    end
  end

  def truncate_words(word, extreme = false)
    word.gsub!("CENTRO", "C.")

    truncated_word = (extreme == true) ? "" : "SOCIOED."
    word.gsub!("SOCIOEDUCATIVO", truncated_word)

    truncated_word = (extreme == true) ? "" : "ED."
    word.gsub!("EDUCACIONAL", truncated_word)

    truncated_word = (extreme == true) ? "" : "UN."
    word.gsub!("UNIDADE", truncated_word)

    word.gsub!("INTERNAÇÃO", "INT.")
    word.gsub!("SEMILIBERDADE", "SEMILIB.")
    word.gsub!("PROVISÓRIA", "PROV.")
    word.gsub!("Internação Provisória", "IP")
    word.gsub!("Internação", "I")
    word.gsub!("Sanção", "S")


    truncated_word = (extreme == true) ? "" : "DE "
    word.gsub!("DE ", truncated_word)

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
