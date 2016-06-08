class UnitsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_unit, only: [:show, :edit, :update, :destroy]

  def index
    @units = policy_scope(Unit.order(:id)).page(params[:page])
    respond_with(@units)
  end

  def show
    authorize @unit
    respond_with(@unit, layout: false)
  end

  def edit
    authorize @unit
    respond_with(@unit)
  end

  def update
    authorize @unit
    if @unit.street == params[:unit][:street]
      @unit.update(unit_params)
    else
      @unit.update(unit_params)
      @unit.geocode
    end
    respond_with(@unit, location: -> { units_path })
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
      :street,
      :county,
      :district,
      :photo,
      :photo_cache,
      :latitude,
      :longitude,
      measure_type_ids: []
    )
  end
end
