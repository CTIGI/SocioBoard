class OffendersController < ApplicationController
  include Concerns::OffendersControllerConcern

  def index
    if params.include?(:search) || !params[:q].present?
      @q = Offender.ransack(session[:query_search])
      @result = @q.result
      @offenders = @result.page(params[:page])
      respond_with(@offenders)
    elsif params.include?(:export_pdf)
      redirect_to action: :generate_pdf, format: :pdf
    elsif params.include?(:export_sheet)
      redirect_to action: :generate_sheet, format: :xlsx
    end
  end

  def modal_index
    @q = Offender.ransack(params_search)
    @offenders = @q.result
    respond_with(@offenders, layout: false)
  end

end
