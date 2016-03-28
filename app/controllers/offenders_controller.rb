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
end
