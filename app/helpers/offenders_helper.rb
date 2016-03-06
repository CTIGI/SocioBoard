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
  end
end
