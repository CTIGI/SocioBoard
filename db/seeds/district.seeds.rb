districts = YAML.load_file(Rails.root.join('config', 'districts_latlong.yml'))
binding.pry

districts.each do |district|
  District.where(name: district['name'], latitude: district['lat'], longitude: district['long']).first_or_create
end
