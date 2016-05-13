class UnitOccupationWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  sidekiq_options queue: :unit_occupation

  recurrence { daily }

  def perform()
    Unit.all.each do |unit|
      uc = UnitOccupation.where(unit_id: unit.id, day: Date.today).first_or_initialize
      uc.occupation = unit.offenders.not_evaded.count
      uc.save
    end
  end
end
