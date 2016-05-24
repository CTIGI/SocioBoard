require 'yaml'

namespace :load do
  desc "Load geolocalization data for the units"
  task :unit_addresses => [:environment] do
    unit_addresses = YAML.load_file File.join(Rails.root, 'config', 'unit_addresses.yml')
    unit_addresses.each do |ua|
      unit = Unit.where(name: ua["name"]).first
      unit.street = ua["street"]
      unit.district = ua["district"]
      unit.county = ua["county"]
      unit.geocode
      unit.save
      
    end
  end
end
