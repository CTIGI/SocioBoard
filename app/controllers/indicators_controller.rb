class IndicatorsController < ApplicationController
  include Concerns::SharedChartsDataConcern

  before_action :set_values, only: [ :indicator_01 ]
  before_action :units_capacity_data, only: [ :indicator_01 ]
  before_action :units_inconsistences, only: [ :indicator_01 ]
  before_action :units_inconsistences_data_chart, only: [ :indicator_01 ]

  def indicator_01
    authorize :indicator
  end

end
