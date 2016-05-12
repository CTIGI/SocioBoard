class DashboardController < ApplicationController
  include Concerns::SharedChartsDataConcern

  before_action :authenticate_user!
  skip_after_action :verify_policy_scoped
  before_action :set_units, :set_crimes_name, :set_measure_names

  def index
    crimes_by_unit_chart
    measure_by_unit_chart
    set_units_capacity_charts
    set_daily_occupation_chart
  end

  private

  def set_daily_occupation_chart
    categories = []

    UnitOccupation.all.ordered_by_date.group(:day).count.each do |uc|
      categories << uc[0]
    end

    gon.daily_occupation_categories = categories

    series = []

    Unit.all.each do |unit|
      ucs = UnitOccupation.where(unit: unit).ordered_by_date
      data = []
      ucs.each do |uc|
        data << uc.occupation
      end

      series << {name: unit.name, data: data}
    end
    gon.daily_occupation_series = series
  end

  def measure_by_unit_chart
    measure_by_units = { }

    @units.each do |u|
      measure_by_units[u.last] = []
    end

    gon.measure_by_units_categories = @units

    units_hash = Hash[@units]

    Offender.not_evaded.joins(:measures).group("measures.measure_type", :unit_id).count.each do |o|
      measure_by_units[units_hash[o.first.last]] << { o.first.first => o.last }
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

    @units.each do |u|
      crimes_by_units[u.last] = []
    end

    units_hash = Hash[@units]
    Offender.not_evaded.group(:unit_id).joins(:crimes).group("crimes.name").count.each do |o|
      crimes_by_units[units_hash[o.first.first]] << { o.first.last => o.last }
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
    @units = Unit.pluck(:id, :name)
  end

  def set_crimes_name
    @crime_names = Crime.all.map(&:name)
  end

  def set_measure_names
    @measures_names = Measure.uniq.pluck(:measure_type)
  end
end
