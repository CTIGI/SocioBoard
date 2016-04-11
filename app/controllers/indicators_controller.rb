class IndicatorsController < ApplicationController
  include Concerns::SharedChartsDataConcern

  before_action :set_values, only: [ :indicator_01 ]
  before_action :units_capacity_data, only: [ :indicator_01 ]
  before_action :units_inconsistences, only: [ :indicator_01 ]
  before_action :units_inconsistences_data_chart, only: [ :indicator_01 ]
  before_action :params_search, only: [ :units]

  def indicator_01
    authorize :indicator
  end

  def units
    authorize :indicator
    @q = Unit.ransack(params[:q])
    @units_group = @q.result.to_a
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
