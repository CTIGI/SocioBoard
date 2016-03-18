require 'rails_helper'

RSpec.describe Unit, :type => :model do
  it "should have a factory" do
    expect(FactoryGirl.build(:unit)).to be_valid
  end

  context "Should Respond" do
    it { should respond_to(:name) }
    it { should respond_to(:occupied) }
    it { should respond_to(:capacity) }
    it { should respond_to(:min_age) }
    it { should respond_to(:max_age) }
  end

  context "Associations" do
    it { should have_many(:offenders) }
  end

  context "validations" do
    it "max age should be bigger than 12 and lower than 22" do
      unit = build(:unit, max_age: 23)
      expect(unit.save).to eq false
      unit.max_age = 22
      expect(unit.save).to eq true
      unit.max_age = 11
      expect(unit.save).to eq false
    end

    it "min age should be bigger than 12 and lower than 22" do
      unit = build(:unit, min_age: 23)
      expect(unit.save).to eq false
      unit.min_age = 21
      expect(unit.save).to eq true
      unit.min_age = 11
      expect(unit.save).to eq false
    end

    it "should validate if end_date is bigger than start_date" do
      unit = build(:unit, max_age: 12, min_age: 22)
      expect(unit.save).to eq false
      expect(unit.errors.messages[:max_age]).to eq [I18n.t("activerecord.errors.models.attributes.unit.min_age_bigger_than_max")]
    end
  end

end
