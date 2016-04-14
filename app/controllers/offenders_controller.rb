class OffendersController < ApplicationController
  include Concerns::OffendersControllerConcern

  def index
    @q = Offender.ransack(params[:q])
    @result = @q.result
    @offenders = @result.page(params[:page])
    respond_with(@offenders)
  end

  def modal_index
    if params[:unit_id]
      @offenders = Offender.where(unit_id: params[:unit_id]).where("age < 12 OR age > 20")
    else
      @offenders = Offender.ransack(params[:q]).result
    end
    respond_with(@offenders, layout: false)
  end

end
