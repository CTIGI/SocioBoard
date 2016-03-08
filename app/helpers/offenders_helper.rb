module OffendersHelper
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
        result << (
          content_tag(:div, class: "col-sm-1 col-xs-6") do
            concat(
              content_tag(:div, class: "cb-item") do
                concat(
                  content_tag(:small, c.keys[0])
                )
                concat(
                  content_tag(:h3, c.values[0])
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
