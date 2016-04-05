class OffendersController < ApplicationController
  include Concerns::OffendersControllerConcern

  def index
    if params.include?(:export_pdf)
      redirect_to action: :generate_pdf, format: :pdf
    elsif params.include?(:export_sheet)
      redirect_to action: :generate_sheet, format: :xlsx
    else
      @q = Offender.ransack(session[:query_search])
      @result = @q.result
      @offenders = @result.page(params[:page])
      respond_with(@offenders)
    end
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
