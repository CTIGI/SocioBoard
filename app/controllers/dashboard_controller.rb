class DashboardController < ApplicationController
  before_action :set_units, :set_crimes_name, :set_measure_names

  def index
    crimes_by_unit_chart
    measure_by_unit
  end

  private

  def measure_by_unit
    measure_by_units = { }

    @units.each do |unit|
      measure_by_units[unit] = []
    end

    gon.measure_by_units_categories = @units

    Offender.joins(:measures).group("measures.measure_type", :unit).count.each do |o|
      measure_by_units[o.first.last] << { o.first.first => o.last }
    end

    series = []

    @measures_names.each_with_index do |measure_name, i|
      series << { name: measure_name , data: [] }
      measure_by_units.each do |mbu|
        series[i][:data] << mbu.last.reduce(Hash.new, :merge)[measure_name]
      end
    end

    gon.measures_by_units = series
  end


  def crimes_by_unit_chart
    crimes_by_units = { }

    gon.crimes_by_unit_categories = @units

    @units.each do |unit|
      crimes_by_units[unit] = []
    end

    Offender.group(:unit).joins(:crimes).group("crimes.name").count.each do |o|
      crimes_by_units[o.first.first] << { o.first.last => o.last }
    end

    series = []

    @crime_names.each_with_index do |crime_name, i|
      series << { name: crime_name , data: [] }
      crimes_by_units.each do |cbu|
        series[i][:data] << cbu.last.reduce(Hash.new, :merge)[crime_name]
      end
    end

    gon.crimes_by_units = series
  end

  def set_units
    @units = []
    Offender.group(:unit).count.each do |unit|
      @units << unit.first
    end
  end

  def set_crimes_name
    @crime_names = Crime.all.map(&:name)
  end

  def set_measure_names
    @measures_names = Measure.uniq.pluck(:measure_type)
  end
end
