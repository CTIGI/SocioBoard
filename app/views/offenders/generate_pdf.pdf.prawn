def result_search(pdf, data_result)
  pdf.fill_color '068E4E'
  pdf.fill_rectangle [0, 470], 780, 60
  pdf.move_down 25
  pdf.fill_color 'ffffff'
  cell_style = { borders: [ :right],
                 border_width: 10,
                 border_color: "068E4E",
                 size: 8,
                 align: :center,
                 background_color: "3DA775",
                 inline_format: "true"
               }

  pdf.table(data_result, column_widths: Array.new(data_result[1].size, 120), cell_style: cell_style, position: 10)
end

def range_dates_measure(start_date_measure, end_date_measure)
  start_date_measure = start_date_measure == t("app.no_record") ? "" : l(start_date_measure.to_date)
  end_date_measure   = end_date_measure == t("app.no_record") ? "" : l(end_date_measure.to_date)
  "#{start_date_measure}<br/>#{end_date_measure}"
end

def table_result_search(pdf)
  pdf.move_down 10
  pdf.fill_color '000000'

  cell_style = {
    size: 7,
    inline_format: "true"
  }

  header = [
    t('activerecord.attributes.offender.unit'),
    t('activerecord.attributes.offender.name'),
    t('activerecord.attributes.offender.age'),
    t('activerecord.attributes.offender.recurrent'),
    t('activerecord.attributes.offender.origin_county'),
    t('activerecord.attributes.offender.article'),
    t('views.offenders.filter_panel.currrent_period_measure_type'),
    t('activerecord.attributes.offender.measures_measure_deadline'),
    t('activerecord.attributes.offender.measure_dates')
  ]

  if evaded_search
    header << t('activerecord.attributes.offender.evasion_date')
  end

  result = [header]

  @offenders.each do |offender|
    result << [
      truncate_words(offender.unit.name),
      display_offender_name(offender.name, current_user),
      show_field(offender.age),
      show_field(offender.recurrent),
      show_field(offender.origin_county),
      show_field(offender.crimes.pluck(:name).join(", ")),
      "#{period_label(offender)} #{UnicodeUtils.upcase(measure_data(offender, :measure_type))} <br/>#{
      (measure_data(offender, :measure_situation))}",
      measure_data(offender, :measure_deadline),
      range_dates_measure(measure_data(offender, :start_date_measure), measure_data(offender, :end_date_measure))
    ]

    if evaded_search
      result.last <<  l(offender.evasion_date) if offender.evasion_date
    end
  end

  pdf.table(result, column_widths: [100, 100, 40, 50], cell_style: cell_style)
end

prawn_document(page_layout: :landscape) do |pdf|
  template = PDFTemplate.new(pdf)
  template.header(t("views.reports.offenders_list"))
  result_search(pdf, @data_result)
  table_result_search(pdf)
end
