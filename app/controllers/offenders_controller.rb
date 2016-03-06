class OffendersController < ApplicationController
  before_action :set_dependencies

  def index
    @q = Offender.ransack(params[:q])
    @offenders = @q.result.page(params[:page])
  end

  private
  def set_dependencies
    @total              = Offender.all.count
    @units              = Offender.order(:unit).select("distinct(unit)")
    @ages               = Offender.order(:age).select("distinct(age)")
    @recurrents         = Offender.order(:recurrent).select("distinct(recurrent)")
    @origin_counties    = Offender.order(:origin_county).select("distinct(origin_county)")
    @articles           = Offender.order(:article).select("distinct(article)")
    @measure_types      = Offender.order(:measure_type).select("distinct(measure_type)")
    @measure_deadlines  = Offender.order(:measure_deadline).select("distinct(measure_deadline)")
    @measure_situations = Offender.order(:measure_situation).select("distinct(measure_situation)")
  end
end
