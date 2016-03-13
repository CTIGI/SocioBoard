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
    it { should respond_to(:near_due_date) }
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
        create_list(:measure, measures_count1, near_due_date: true, offender_id: offender.id)
        create_list(:measure, measures_count2, near_due_date: false, offender_id: offender.id)
        expect(Measure.nears_due_date.count).to eq(measures_count1)
      end
    end
  end
end
