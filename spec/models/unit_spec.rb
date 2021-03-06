require 'rails_helper'

RSpec.describe Unit, :type => :model do
  it "should have a factory" do
    expect(FactoryBot.build(:unit)).to be_valid
  end

  context "Should Respond" do
    it { should respond_to(:name) }
    it { should respond_to(:occupied) }
    it { should respond_to(:capacity) }
    it { should respond_to(:min_age) }
    it { should respond_to(:max_age) }
    it { should respond_to(:street) }
    it { should respond_to(:district) }
    it { should respond_to(:latitude) }
    it { should respond_to(:longitude) }
  end

  context "Associations" do
    it { should have_many(:offenders) }
    it { should have_many(:unit_occupations) }
    it { should have_and_belong_to_many :measure_types }
  end

  context "Instance Methods" do
    describe ".full_address" do
      it "should return the unit full address" do
        unit = build(:unit, street: "Street", county: "County")
        expect(unit.full_address).to eq "Street, County"
      end
    end

    describe ".biggest_occupation" do
      let(:unit) { create(:unit) }

      it "Return biggest occupation of the unit" do
        uc = create(:unit_occupation, unit: unit, day: Date.today - 30, occupation: 99)
        uc = create(:unit_occupation, unit: unit, day: Date.today - 30, occupation: 100)

        expect(unit.biggest_occupation).to eq 100
      end
    end

    describe ".lowest_occupation" do
      let(:unit) { create(:unit) }

      it "Return biggest occupation of the unit" do
        uc = create(:unit_occupation, unit: unit, day: Date.today - 30, occupation: 99)
        uc = create(:unit_occupation, unit: unit, day: Date.today - 30, occupation: 100)

        expect(unit.lowest_occupation).to eq 99
      end
    end

    describe ".occupation_variation" do
      let(:unit) { build(:unit) }

      it "Should return variation from 30 days ago" do
        uc = build(:unit_occupation, unit: unit, day: Date.today - 30, occupation: 99)
        unit.unit_occupations << uc

        expect(unit).to receive_message_chain(:offenders, :not_evaded, :count).and_return(100)
        expect(unit).to receive_message_chain(:unit_occupations, :where, :first).and_return(uc)

        expect(unit.occupation_variation(Date.today - 30)).to eq 1
      end

      it "Should return variation if there is no record 30 days ago" do
        expect(unit).to receive_message_chain(:offenders, :not_evaded, :count).and_return(100)

        expect(unit.occupation_variation(Date.today - 30)).to eq 100
      end
    end

    describe ".occupation_variation_percentage" do
      let(:unit) { create(:unit) }

      it "Should return variation from 30 days ago" do
        uc = create(:unit_occupation, unit: unit, day: Date.today - 30, occupation: 2)
        unit.offenders << create(:offender)
        unit.unit_occupations << uc

        expect(unit.occupation_variation_percentage(Date.today - 30)).to eq -100.0
      end

      it "Should return variation if there is no record 30 days ago" do
        expect(unit.occupation_variation_percentage(Date.today - 30)).to eq 0
      end
    end

    describe ".occupation_increased?" do
      let(:unit) { build(:unit) }

      it "should return true if occupation has increased in the last 30 days" do
        uc = build(:unit_occupation, unit: unit, day: Date.today - 30, occupation: 99)
        unit.unit_occupations << uc

        expect(unit).to receive_message_chain(:offenders, :not_evaded, :count).and_return(100)
        expect(unit).to receive_message_chain(:unit_occupations, :where, :first).and_return(uc)

        expect(unit.occupation_increased?(Date.today - 30)).to eq true
      end

      it "should return false if occupation has decreased in the last 30 days" do
        uc = build(:unit_occupation, unit: unit, day: Date.today - 30, occupation: 99)
        unit.unit_occupations << uc

        expect(unit).to receive_message_chain(:offenders, :not_evaded, :count).and_return(90)
        expect(unit).to receive_message_chain(:unit_occupations, :where, :first).and_return(uc)

        expect(unit.occupation_increased?(Date.today - 30)).to eq false
      end

      it "should return true if have no occupation in the last 30 days" do
        expect(unit.occupation_increased?(Date.today - 30)).to eq true
      end
    end

    describe ".offenders_out_of_profile" do
      it "should count offfenders out of profile" do
        unit = create(:unit, min_age: 12, max_age: 14, capacity: 2)
        mt_1 = create(:measure_type, name: "Unidade de Internação")

        unit.measure_types << mt_1

        offender_1 = create(:offender, age: 12, unit: unit)
        measure = create(:measure, measure_type: "Internação", offender: offender_1 )

        offender_2 = create(:offender, age: 12, unit: unit)
        measure = create(:measure, measure_type: "SemiLiberdade", offender: offender_2 )

        offender_1 = create(:offender, age: 12, unit: unit)
        offender_2 = create(:offender, age: 15, unit: unit)

        expect(unit.offenders_out_of_profile). to eq 2
      end
    end

    describe ".offenders_out_of_measure" do
      it "should count offfenders out of measure" do
        unit = create(:unit, min_age: 12, max_age: 14, capacity: 2)
        mt_1 = create(:measure_type, name: "Unidade de Internação")

        unit.measure_types << mt_1

        offender_1 = create(:offender, age: 12, unit: unit)
        measure = create(:measure, measure_type: "Internação", offender: offender_1 )

        expect(unit.offenders_out_of_measure). to eq 0

        offender_2 = create(:offender, age: 12, unit: unit)
        measure = create(:measure, measure_type: "SemiLiberdade", offender: offender_2 )

        expect(unit.offenders_out_of_measure). to eq 1
      end
    end

    describe ".measure_type_names" do
      it "should return the number of offenders out of profile percentage" do
        unit = create(:unit, min_age: 12, max_age: 14, capacity: 2)
        mt_1 = create(:measure_type)
        mt_2 = create(:measure_type)

        unit.measure_types << mt_1
        unit.measure_types << mt_2

        expect(unit.measure_type_names). to eq "#{ mt_1.name },#{ mt_2.name }"
      end
    end

    describe ".offenders_out_of_profile_by_age" do
      it "should return the number of offenders out of profile" do
        unit = create(:unit, min_age: 12, max_age: 14)
        offender_1 = create(:offender, age: 12, unit: unit)
        offender_2 = create(:offender, age: 15, unit: unit)

        expect(unit.offenders_out_of_profile_by_age). to eq 1
      end
    end

    describe ".inconsistences" do
      it "should return the number of offenders with inconsistences" do
        unit = create(:unit, min_age: 12, max_age: 14)
        offender_1 = create(:offender, age: 12, unit: unit)
        offender_2 = create(:offender, age: 0, unit: unit)
        offender_2 = create(:offender, age: 23, unit: unit)

        expect(unit.inconsistences). to eq 2
      end
    end

    describe ".offenders_out_of_profile_percentage" do
      it "should return the number of offenders out of profile percentage" do
        unit = create(:unit, min_age: 12, max_age: 14, capacity: 2)
        offender_1 = create(:offender, age: 12, unit: unit)
        offender_2 = create(:offender, age: 15, unit: unit)

        expect(unit.offenders_out_of_profile_percentage). to eq 50
      end
    end

    describe ".analysis_data_count" do
      it "should return an array with [ total_out_of_measure, total_out_of_age, total_age_and_measure, total_conformities ]" do
        unit = create(:unit)
        unit.measure_types << create(:measure_type)
        expect(unit.analysis_data_count).to eq([0, 0, 0, 0])
      end
    end
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
