class DashboardController < ApplicationController
  include Concerns::SharedChartsDataConcern

  before_action :authenticate_user!
  skip_after_action :verify_policy_scoped
  before_action :set_units, :set_crimes_name, :set_measure_names

  def index
    crimes_by_unit_chart
    measure_by_unit_chart
    #unit_by_measure_chart
    #unit_by_crime_chart
    set_units_capacity_charts
  end

  # def unit_by_measure_chart
  #   units_by_measures = { }
  #
  #   @measures_names.each do |measure|
  #     units_by_measures[measure] = []
  #   end
  #
  #   series = []
  #
  #   gon.units_by_measures_categories = @measures_names
  #
  #   Offender.joins(:measures).group("measures.measure_type", :unit).count.each do |o|
  #     units_by_measures[o.first.first] << { o.first.last => o.last }
  #   end
  #
  #   @units.each_with_index do |unit_name, i|
  #     series << { name: unit_name , data: [] }
  #     units_by_measures.each do |ubm|
  #       series[i][:data] << ubm.last.reduce(Hash.new, :merge)[unit_name]
  #     end
  #   end
  #
  #   gon.units_by_measures = series
  # end

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

  # def unit_by_crime_chart
  #   units_by_crimes = { }
  #
  #   gon.units_by_crimes_categories = @crime_names
  #
  #   @crime_names.each do |crime|
  #     units_by_crimes[crime] = []
  #   end
  #
  #   Offender.group(:unit).joins(:crimes).group("crimes.name").count.each do |o|
  #     units_by_crimes[o.first.last] << { o.first.first => o.last }
  #   end
  #
  #   series = []
  #
  #   @units.each_with_index do |unit_name, i|
  #     series << { name: unit_name , data: [] }
  #     units_by_crimes.each do |ubc|
  #       series[i][:data] << ubc.last.reduce(Hash.new, :merge)[unit_name]
  #     end
  #   end
  #
  #   gon.units_by_crimes = series
  #end


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
