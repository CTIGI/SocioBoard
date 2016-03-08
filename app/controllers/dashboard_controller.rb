class DashboardController < ApplicationController
  before_action :set_units, :set_crimes_name

  def index
    crimes_by_unit_chart
  end

  private

  def measure_by_unit
    Offender.joins(:measures).group("measures.measure_type", :unit).count
  end


  def crimes_by_unit_chart
    gon.crimes_by_unit_categories = []
    crimes_by_units = { }

    gon.crimes_by_unit_categories = @units

    @units.each do |unit|
      crimes_by_units[unit] = []
    end

    result = Offender.group(:unit).joins(:crimes).group("crimes.name").count
    result.each do |r|
      crimes_by_units[r.first.first] << { r.first.last => r.last }
    end

    series = []

    @crime_names.each_with_index do |crime_name, i|
      series << { name: crime_name , data: [] }
      crimes_by_units.each do |cbu|
        series[i][:data] << cbu.last.reduce(Hash.new, :merge)[crime_name]
      end
    end

    gon.crimes_by_unit = series
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
end
