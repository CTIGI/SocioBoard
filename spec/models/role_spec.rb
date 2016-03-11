require 'rails_helper'

RSpec.describe Role, :type => :model do
  it "should have a factory" do
    expect(FactoryGirl.build(:role)).to be_valid
  end

  context "Associations" do
    it { should have_and_belong_to_many :users }
  end

  context "Should Respond" do
    it { should respond_to(:name) }
    it { should respond_to(:activities) }
    it { should respond_to(:users) }
  end
end
