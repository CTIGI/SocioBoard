class OffendersController < ApplicationController
  def index
    @q = Offender.ransack(params[:q])
    @offenders = @q.result.page(params[:page])
  end
end
