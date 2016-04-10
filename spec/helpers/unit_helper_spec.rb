require 'rails_helper'

RSpec.describe UnitHelper, :type => :helper do
  describe "#age_range" do
    it "should return age range formatted" do
      min, max = 10, 20
      expect(helper.age_range(10,20)).to eq("#{min} - #{max}")
    end
  end

  describe "#initials_measure_unit_type" do
    it "should return initials from measure unit type" do
      free_range_unit = [ I18n.t("measure_units_types.free_range_unit") ]
      expect(helper.initials_measure_unit_type(free_range_unit)).to eq(t("views.indicators.units.free_range_unit_initial"))

      free_range_unit = [ I18n.t("measure_units_types.admission_unit") ]
      expect(helper.initials_measure_unit_type(free_range_unit)).to eq(t("views.indicators.units.admission_unit_initial"))

      free_range_unit = [ I18n.t("measure_units_types.provisional_admission_unit") ]
      expect(helper.initials_measure_unit_type(free_range_unit)).to eq(t("views.indicators.units.provisional_admission_unit_initial"))
    end
  end
end
