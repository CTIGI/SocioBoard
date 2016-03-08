require 'rails_helper'

RSpec.describe OffendersHelper, :type => :helper do

  describe "#generate_preview_numbers" do
    it "should display preview numbers and label" do
      label = Faker::Name.name
      value = Faker::Number.number(2)
      total = [{ label => Faker::Number.number(2) }]
      obj = [{ label => value }]
      percentage = (value.to_f * 100 / total[0].values[0].to_f).round(2)

      expect(helper.generate_preview_numbers(obj, total, true)).to eq(
        "<div class=\"col-sm-2 col-xs-6\"><div class=\"cb-item\"><small>#{label}</small><h3>#{value} (#{percentage}%)</h3></div></div>"
      )
    end
  end

  describe "#truncate_words" do
    it "should truncate some words into string" do
      expect(helper.truncate_words("CENTRO")).to eq("C.")
      expect(helper.truncate_words("SOCIOEDUCATIVO")).to eq("SOCIOED.")
      expect(helper.truncate_words("EDUCACIONAL")).to eq("ED.")
      expect(helper.truncate_words("UNIDADE")).to eq("UN.")
      expect(helper.truncate_words("INTERNAÇÃO")).to eq("INT.")
      expect(helper.truncate_words("PROVISÓRIA")).to eq("PROV.")
      expect(helper.truncate_words("SEMILIBERDADE")).to eq("SEMILIB.")
      expect(helper.truncate_words("SEMILIBERDADE")).to eq("SEMILIB.")
      expect(helper.truncate_words("ALOISIO")).to eq("AL.")
      expect(helper.truncate_words("ZEQUINHA")).to eq("ZEQ.")
      expect(helper.truncate_words("BARBOSA")).to eq("B.")
      expect(helper.truncate_words("FRANCISCO")).to eq("FCO.")
    end
  end

  describe "#measure_data" do
    it "should return message with no data if offender haven't a measure" do
      offender = create(:offender)
      expect(helper.measure_data(offender, :measure_type)).to eq(t("app.no_record"))
    end

    it "should return data with commas separated if offender have it a measure" do
      offender      = create(:offender)
      measures      = create_list(:measure, 3, offender_id: offender.id)
      measure_types = measures.map { |m| m.measure_type }
      expect(helper.measure_data(offender, :measure_type)).to eq(measure_types.join(", "))
    end
  end
end
