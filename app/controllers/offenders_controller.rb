class OffendersController < ApplicationController
  include Concerns::OffendersControllerConcern

  def index

    if params[:q]
      if params[:q].include? "evaded_eq"
        @q = Offender.order(:unit_id, :name).ransack(params[:q])
      else
        @q = Offender.not_evaded.order(:unit_id, :name).ransack(params[:q])
      end
    else
      @q = Offender.not_evaded.order(:unit_id, :name).ransack(params[:q])
    end

    @result = @q.result

    @offenders = @result.page(params[:page])
    respond_with(@offenders)
  end

  def modal_index
    if params[:unit_id]
      @offenders = Offender.not_evaded.where(unit_id: params[:unit_id]).where("age < 12 OR age > 20")
    else
      @offenders = Offender.not_evaded.ransack(params[:q]).result
    end
    respond_with(@offenders, layout: false)
  end
end
