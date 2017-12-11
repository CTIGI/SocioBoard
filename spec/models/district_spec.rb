require 'rails_helper'

RSpec.describe District, :type => :model do

  it "should have a factory" do
    expect(FactoryBot.build(:district)).to be_valid
  end

  context "should respond" do
    it { should respond_to(:name) }
    it { should respond_to(:latitude) }
    it { should respond_to(:longitude) }
    it { should respond_to(:created_at) }
    it { should respond_to(:updated_at) }
  end

  context "Associations" do
    it { should have_many(:offenders) }
  end

end
