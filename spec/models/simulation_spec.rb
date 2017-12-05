require 'rails_helper'

RSpec.describe Simulation, :type => :model do
  it "should have a factory" do
    expect(FactoryBot.build(:simulation)).to be_valid
  end

  context "Associations" do
    it { should belong_to :user }
  end

  context "Should Respond" do
    it { should respond_to(:name) }
    it { should respond_to(:data) }
    it { should respond_to(:div_text) }
  end
end
