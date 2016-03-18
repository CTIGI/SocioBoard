class OffendersController < ApplicationController
  include Concerns::OffendersControllerConcern
  skip_after_action :verify_policy_scoped

  def index
    @q = Offender.ransack(params_search)
    @offenders = @q.result.page(params[:page])
  end
end
