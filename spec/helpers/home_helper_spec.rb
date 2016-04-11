require 'rails_helper'

RSpec.describe HomeHelper, :type => :helper do

  describe "#underflow" do
    it "should return underflow 0 and the markup if positive" do
      occupied = rand(100)
      unit  = FactoryGirl.build(:unit, capacity: occupied*2, occupied: occupied)
      expect(helper.underflow(unit.capacity, unit.occupied)).to eq([0, ""])
    end

    it "should return underflow with value and the markup if negative" do
      occupied   = rand(51..100)
      capacity   = rand(50)
      unit       = FactoryGirl.build(:unit, capacity: capacity, occupied: occupied)
      total      = (capacity - occupied).abs
      percentage = ((total.abs * 100)/capacity).round(2)
      expect(helper.underflow(unit.capacity, unit.occupied)).to eq(["#{total.abs} (#{percentage}%)", "danger-item"])
    end
  end

  describe "#render_admission_data" do
    it "should return render admission data if positive" do
      near_admission_date = rand(1..10)
      expect(helper.render_admission_data(near_admission_date)).to eq([near_admission_date, "warning-item"])
    end

    it "should return render admission data 0 if negative or equal zero" do
      near_admission_date = 0
      expect(helper.render_admission_data(near_admission_date)).to eq([0, ""])
    end
  end
end
