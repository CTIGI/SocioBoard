require 'rails_helper'

RSpec.describe OffendersHelper, :type => :helper do

  describe "#evaded_search?" do
    it "should return true if param has filled in" do
      allow(controller).to receive_messages(:params => { q: { "evaded_eq" => "true" } })
      expect(helper.evaded_search).to eq(true)
    end

    it "should return false if param not exist" do
      allow(controller).to receive_messages(:params => { })
      expect(helper.evaded_search).to eq(false)
    end
  end

  describe "#is_checked?" do
    it "should return true if param has filled in" do
      allow(controller).to receive_messages(:params => { units: { free_range_units: "true" } })
      expect(helper.is_checked?(:units, :free_range_units)).to eq(true)
    end

    it "should return false if param not exist" do
      allow(controller).to receive_messages(:params => { })
      expect(helper.is_checked?(:units, :free_range_units)).to eq(false)
    end
  end

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

    it "mode EXTREME" do
      expect(helper.truncate_words("SOCIOEDUCATIVO", true)).to eq("")
      expect(helper.truncate_words("EDUCACIONAL", true)).to eq("")
      expect(helper.truncate_words("UNIDADE", true)).to eq("")
      expect(helper.truncate_words("UNIDADE", true)).to eq("")
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

  describe "#colorize_table_row" do
    it "should return near_current_period if measure have it current_period_date less or equal than today date more 30 days" do
      offender = create(:offender)
      measure = create(:measure, offender_id: offender.id)
      expect(helper.colorize_table_row(measure.offender)).to eq("near_current_period")
    end

    it "should return overdue_measure if measure end date less than today and measure_type is provisional_admission" do
      offender = create(:offender)
      measure = create(:measure,
                       offender_id: offender.id,
                       measure_type: I18n.t("activerecord.attributes.offender.measure_type_list.provisional_admission"),
                       end_date_measure: Faker::Date.backward(14),
                       current_period_date: "")
      expect(helper.colorize_table_row(measure.offender)).to eq("overdue_measure")
    end

    it "should return nothing if measure have it current_period_date less or equal than today date more 30 days" do
      offender = create(:offender)
      measure = create(:measure, offender_id: offender.id, current_period_date: "")
      expect(helper.colorize_table_row(measure.offender)).to be_blank
    end
  end

  describe "#value_selected" do
    it "should return blank array if haven't params" do
      allow(controller).to receive_messages(params: { q: {} })
      expect(helper.value_selected("q", "test")).to eq([""])
    end

    it "should return value array if have params" do
      value = rand(1..10)
      allow(controller).to receive_messages(params: { q: { test: value } })
      expect(helper.value_selected(:q, :test)).to eq(value)
    end
  end

  describe "#links_to_export" do
    it "should return links to export" do
      expect(helper.links_to_export).to include("export_pdf")
      expect(helper.links_to_export).to include(generate_pdf_offenders_path)
      expect(helper.links_to_export).to include(".pdf")
      expect(helper.links_to_export).to include(t("views.general.export.to_pdf"))

      expect(helper.links_to_export).to include("export_sheet")
      expect(helper.links_to_export).to include(generate_sheet_offenders_path)
      expect(helper.links_to_export).to include(".xlsx")
      expect(helper.links_to_export).to include(t("views.general.export.to_excel"))
    end
  end
end
