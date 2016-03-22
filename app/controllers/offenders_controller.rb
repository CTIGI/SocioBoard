class OffendersController < ApplicationController
  include Concerns::OffendersControllerConcern
  before_action :authenticate_user!
  before_action :set_dependencies
  before_action :set_counters
  skip_after_action :verify_policy_scoped
  skip_after_action :verify_authorized

  def index
    @q = Offender.ransack(params_search)
    @offenders = @q.result.page(params[:page])
    respond_with(@offenders)
  end

  def modal_index
    @q = Offender.ransack(params_search)
    @offenders = @q.result
    respond_with(@offenders, layout: false)
  end
end
