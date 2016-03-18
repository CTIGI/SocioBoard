class AnalysisController < ApplicationController
  before_action :authenticate_user!
  skip_after_action :verify_policy_scoped
  skip_after_action :verify_authorized

  def unconformities
    @units = Unit.all
  end
end
