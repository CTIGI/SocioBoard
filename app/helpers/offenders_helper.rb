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

  def generate_preview_numbers(title, value)
    content_tag(:div, class: "col-sm-1 col-xs-6") do
      concat(
        content_tag(:div, class: "cb-item") do
          concat(
            content_tag(:small, title)
          )
          concat(
            content_tag(:h3, value)
          )
        end
      )
    end
  end
end
