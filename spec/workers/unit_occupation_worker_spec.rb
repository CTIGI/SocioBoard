require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

RSpec.describe UnitOccupationWorker do

  it "should enque worker" do
    expect { UnitOccupationWorker.perform_async() }.to change(UnitOccupationWorker.jobs, :size).by(1)
  end

  it "should create unit occupation" do
    unit = create(:unit)
    UnitOccupationWorker.new.perform
    expect(UnitOccupation.all.count).to eq 1
  end
end
