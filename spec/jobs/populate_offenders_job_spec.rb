require 'rails_helper'

RSpec.describe PopulateOffendersJob, :type => :job do

  describe "Methods" do
    describe "#near_due_date?" do
      it "should return true if offender have 10 days or less and measure type is provisional_admission" do
        end_date     = Date.today + 10
        measure_type = I18n.t("activerecord.attributes.offender.measure_type_list.provisional_admission")

        expect(PopulateOffendersJob.new.near_due_date?(end_date, measure_type)).to eq(true)
      end

      it "should return false if offender have 10 days or more" do
        end_date     = Date.today + 11
        measure_type = I18n.t("activerecord.attributes.offender.measure_type_list.provisional_admission")

        expect(PopulateOffendersJob.new.near_due_date?(end_date, measure_type)).to eq(false)

        end_date     = Date.today
        measure_type = Faker::Name.name

        expect(PopulateOffendersJob.new.near_due_date?(end_date, measure_type)).to eq(false)
      end
    end

    describe "#set_total_periods" do
      it "should return the period if measure type is admission" do
        measure_type = I18n.t("activerecord.attributes.offender.measure_type_list.admission")
        end_date_measure = Date.today + 6.months
        expect(PopulateOffendersJob.new.set_total_periods(measure_type, end_date_measure)).to eq(1)
        end_date_measure = Date.today + 12.months

        expect(PopulateOffendersJob.new.set_total_periods(measure_type, end_date_measure)).to eq(2)
      end

      it "should return nothing if measure type isnt admission" do
        measure_type = Faker::Name.name
        end_date_measure = Date.today + 7.months

        expect(PopulateOffendersJob.new.set_total_periods(measure_type, end_date_measure)).to be_nil
      end
    end

    describe "#set_current_period_date" do
      it "should return the current period number and next date period" do
        period = 4
        start_date_measure = Date.today - 12.month
        result = PopulateOffendersJob.new.set_current_period_date(period, start_date_measure)

        expect(result[0]).to eq(2)
      end
    end
  end
end
