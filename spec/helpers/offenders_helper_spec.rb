require 'rails_helper'

RSpec.describe OffendersHelper, :type => :helper do

    describe "#generate_preview_numbers" do
      it "should display preview numbers and label" do
        label = Faker::Name.name
        value = Faker::Number.number(2)
        expect(helper.generate_preview_numbers(label, value)).to eq(
          "<div class=\"col-sm-1 col-xs-6\"><div class=\"cb-item\"><small>#{label}</small><h3>#{value}</h3></div></div>"
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
end
