class UnitsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_unit, only: [:show, :edit, :update, :destroy]

  def index
    @units = policy_scope(Unit).page(params[:page])
    respond_with(@units)
  end

  def show
    authorize @unit
    respond_with(@unit, layout: false)
  end

  def edit
    authorize @unit
    respond_with(@unit, layout: false)
  end

  def update
    authorize @unit
    status = @unit.update(unit_params) ? 200 : 403
    respond_with(@unit, layout: false, status: status)
  end

  private

  def respond_activity(object, issue_id, status)
  end

  def set_unit
    @unit = Unit.find(params[:id])
  end

  def unit_params
    params.require(:unit).permit(
      :min_age,
      :max_age,
      measure_type_ids: []
    )
  end
end
