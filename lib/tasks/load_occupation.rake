require 'csv'

namespace :imports do
  desc "Import CSV with occupation, to run this task rake imports:import_unit_occupation"

  task :import_unit_occupation, [:filename] => [:environment] do |t, args|
    CSV.parse(File.read(args.filename)) do |row|
      unit_occupation = UnitOccupation.where(unit_id: row[1], day: row[2], occupation: row[3]).first_or_initialize
      unit_occupation.save
    end
  end
end
