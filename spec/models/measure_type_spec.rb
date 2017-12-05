require 'rails_helper'

RSpec.describe MeasureType, :type => :model do
  it "should have a factory" do
    expect(FactoryBot.build(:measure_type)).to be_valid
  end

  context "Should Respond" do
    it { should respond_to(:name) }
  end

  context "Associations" do
    it { should have_and_belong_to_many :units }
  end
end
