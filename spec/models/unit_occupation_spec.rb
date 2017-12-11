require 'rails_helper'

RSpec.describe UnitOccupation, :type => :model do
  it "should have a factory" do
    expect(FactoryBot.build(:unit_occupation)).to be_valid
  end

  context "Should Respond" do
    it { should respond_to(:unit) }
    it { should respond_to(:unit_id) }
    it { should respond_to(:day) }
    it { should respond_to(:occupation) }
  end

  context "Associations" do
    it { should belong_to(:unit) }
  end
end
