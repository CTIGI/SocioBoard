class IndicatorsController < ApplicationController
  include Concerns::SharedChartsDataConcern

  skip_after_action :verify_policy_scoped
  skip_after_action :verify_authorized

  before_action :set_values, only: [ :indicator_01 ]
  before_action :units_capacity_data, only: [ :indicator_01 ]
  before_action :units_inconsistences, only: [ :indicator_01 ]
  before_action :units_inconsistences_data_chart, only: [ :indicator_01 ]
  before_action :params_search, only: [ :units]

  def indicator_01
  end

  def units
    @q = Unit.ransack(params[:q])
    @units_group = @q.result.to_a
  end

  def unit_profile
    @unit = Unit.find(params[:id])

    @crimes_chart = []

    @unit.offenders.not_evaded.joins(:crimes).group("crimes.name").count.each do |o|
      @crimes_chart << { name: o.first, y: o.last }
    end

    @categories = []

    UnitOccupation.where(unit: @unit).ordered_by_date.group(:day).count.each do |uc|
      @categories << uc[0]
    end

    @series_occupation = []
    @series_capacity = []

    ucs = UnitOccupation.where(unit: @unit).ordered_by_date
    data = []
    capacity_data = []
    ucs.each do |uc|
      data << uc.occupation
      capacity_data << @unit.capacity
    end

    @series_occupation << [{ name: @unit.name, data: data }, { name: I18n.t("activerecord.attributes.unit.capacity"), data: capacity_data } ]

    @variation_date = Date.today - 30

    @conformities = @unit.offenders.not_evaded.count - @unit.offenders_out_of_profile
  end

  private

  def params_search
    units = []
    params[:q] = {}
    if params[:units].present?
      params[:units].each_value do |value|
        units << value if params[:units].has_value?(value)
      end
      params[:q] = { "measure_types_name_in": units.flatten }.merge(params[:q])
    end
  end
end
