require 'rails_helper'

RSpec.describe OffendersHelper, :type => :helper do

  describe "#generate_preview_numbers" do
    it "should display preview numbers and label" do
      label = Faker::Name.name
      value = Faker::Number.number(2)
      obj = [{ label => value }]
      expect(helper.generate_preview_numbers(obj)).to eq(
        "<div class=\"col-sm-2 col-xs-6\"><div class=\"cb-item\"><small>#{label}</small><h3>#{value}</h3></div></div>"
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

  describe "#near_due_date" do
    it "should return css class .near_due_date to display offenders with end_date_measure less than today + 10 days and measure type equal 'Internação Provisória'" do
      expect(helper.near_due_date("true")).to eq("near_due_date")
    end

    it "should return nothing if offender with end_date_measure greater then today + 10 days" do
      provisional_admission_type = I18n.t("activerecord.attributes.offender.measure_type_list.provisional_admission")
      expect(helper.near_due_date("false")).to be_nil
    end
  end
end
