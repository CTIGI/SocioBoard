require 'rails_helper'

RSpec.describe ApplicationHelper, :type => :helper do
  describe "#show_field" do
    it "should return some value if value not nil" do
      field = "some value"
      expect(helper.show_field(field)).to have_content(field)
    end

    it "should return message with no record if value nil" do
      field = nil
      expect(helper.show_field(field)).to have_content(t("app.no_record"))
    end
  end

  describe "#date_input" do
    it "should return formated date if valid" do
      date = Date.today
      expect(helper.date_input(date)).to eq(date.strftime('%d/%m/%Y'))
    end

    it "should return blank date if invalid" do
      date = nil
      expect(helper.date_input(date)).to be_blank
    end
  end
end
