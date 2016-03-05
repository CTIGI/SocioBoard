require 'rails_helper'

describe Offender, :type => :model do
  
  it "should have a factory" do
    expect(FactoryGirl.build(:offender)).to be_valid
  end

  context "should respond" do
    it { should respond_to(:id_citizen) }
    it { should respond_to(:unit) }
    it { should respond_to(:name) }
    it { should respond_to(:birth_date) }
    it { should respond_to(:age) }
    it { should respond_to(:recurrent) }
    it { should respond_to(:origin_county) }
    it { should respond_to(:article) }
    it { should respond_to(:measure_type) }
    it { should respond_to(:measure_deadline) }
    it { should respond_to(:start_date_measure) }
    it { should respond_to(:end_date_measure) }
    it { should respond_to(:measure_situation) }
    it { should respond_to(:ammount_end_days) }
  end
end
