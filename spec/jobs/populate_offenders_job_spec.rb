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
  end

end
