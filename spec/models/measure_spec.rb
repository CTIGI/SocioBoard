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
    it { should respond_to(:created_at) }
    it { should respond_to(:updated_at) }
  end

  context "Associations" do
    it { should belong_to(:offender) }
  end
end
