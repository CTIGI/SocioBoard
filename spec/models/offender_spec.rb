require 'rails_helper'

describe Offender, :type => :model do

  it "should have a factory" do
    expect(FactoryBot.build(:offender)).to be_valid
  end

  context "should respond" do
    it { should respond_to(:id_citizen) }
    it { should respond_to(:unit) }
    it { should respond_to(:name) }
    it { should respond_to(:birth_date) }
    it { should respond_to(:age) }
    it { should respond_to(:recurrent) }
    it { should respond_to(:origin_county) }
    it { should respond_to(:crimes) }
    it { should respond_to(:crime_id) }
    it { should respond_to(:evaded) }
    it { should respond_to(:evasion_date) }
    it { should respond_to(:has_photo) }
    it { should respond_to(:has_biometry) }
    it { should respond_to(:street) }
    it { should respond_to(:district) }
    it { should respond_to(:address_county) }
    it { should respond_to(:secondary_street) }
    it { should respond_to(:secondary_district) }
    it { should respond_to(:secondary_address_county) }
    it { should respond_to(:latitude) }
    it { should respond_to(:longitude) }
  end

  context "Associations" do
    it { should have_many(:measures) }
    it { should belong_to(:unit) }
    it { should belong_to(:district) }
  end

  context "scopes" do
    it "should return all flagged as duplicated" do
      total_duplicated = rand(1..10)
      duplicated = create_list(:offender, total_duplicated, duplicated: true)
      expect(Offender.duplicated.count).to eq(total_duplicated)
    end
  end
end
