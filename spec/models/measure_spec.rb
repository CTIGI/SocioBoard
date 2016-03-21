require 'rails_helper'

RSpec.describe Measure, :type => :model do

  it "should have a factory" do
    expect(FactoryGirl.build(:measure)).to be_valid
  end

  context "should respond" do
    it { should respond_to(:start_date_measure) }
    it { should respond_to(:end_date_measure) }
    it { should respond_to(:measure_type) }
    it { should respond_to(:measure_deadline) }
    it { should respond_to(:measure_situation) }
    it { should respond_to(:ammount_end_days) }
    it { should respond_to(:offender_id) }
    it { should respond_to(:current_period) }
    it { should respond_to(:current_period_date) }
    it { should respond_to(:created_at) }
    it { should respond_to(:updated_at) }
  end

  context "Associations" do
    it { should belong_to(:offender) }
  end

  context "scopes" do
    context "#nears_due_date" do
      it "should return all near due dates flagged as true" do
        measures_count1 = rand(10)
        measures_count2 = rand(10)
        offender = create(:offender)
        create_list(:measure, measures_count1,
                    end_date_measure: Faker::Date.forward(10),
                    measure_type: I18n.t("activerecord.attributes.offender.measure_type_list.provisional_admission"),
                    offender_id: offender.id)
        create_list(:measure, measures_count2, end_date_measure: Faker::Date.forward(30), offender_id: offender.id)
        expect(Measure.nears_due_date.count).to eq(measures_count1)
      end
    end

    context "#near_current_periods" do
      it "should return all near current periods" do
        measures_count = rand(10)
        offender = create(:offender)
        create_list(:measure, measures_count, current_period_date: Faker::Date.backward(31), offender_id: offender.id)
        expect(Measure.near_current_periods.count).to eq(measures_count)
      end
    end

    context "#overdues" do
      it "should return all overdues" do
        measures_count = rand(10)
        offender = create(:offender)
        measure_type = I18n.t("activerecord.attributes.offender.measure_type_list.provisional_admission")
        create_list(:measure, measures_count, end_date_measure: Faker::Date.backward(31), offender_id: offender.id, measure_type: measure_type)
        expect(Measure.overdues.count).to eq(measures_count)
      end
    end

    context "#sanctions" do
      it "should return all sanctions" do
        sanctions_count = rand(10)
        offender = create(:offender)
        measure_type = I18n.t("activerecord.attributes.offender.measure_type_list.sanction")
        create_list(:measure, sanctions_count, end_date_measure: Faker::Date.backward(9), offender_id: offender.id, measure_type: measure_type)
        expect(Measure.sanctions.count).to eq(sanctions_count)
      end
    end
  end
end
