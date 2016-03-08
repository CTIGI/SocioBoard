module OffendersHelper

  def near_due_date(end_date)
     diff_days = (end_date.to_date - Date.today).to_i
     "near_due_date" if diff_days < 10
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

  def generate_preview_numbers(counters, total, is_show = false)
    unless counters.blank?
      result = ""
      counters.each do |c|
        percentage = (c.values[0].to_f * 100 / total[0].values[0].to_f).round(2)
        value = is_show ? "#{c.values[0]} (#{percentage}%)" : c.values[0]
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
end
