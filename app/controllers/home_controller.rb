class HomeController < ApplicationController
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped
  before_action :params_search

  def index
    @q = Unit.ransack(params[:q])
    @units_group = @q.result.to_a
  end

  private
  def params_search
    units = []
    params[:q] = {}
    if params[:units].present?
      params[:units].each_key do |k|
        measure_unit_type     = Unit.measure_unit_types[k]
        measure_unit_type_ids = Unit.where(measure_unit_type: measure_unit_type).pluck(:id)
        units << measure_unit_type_ids if params[:units].has_key?(k)
      end
      params[:q] = { "id_in": units.flatten }.merge(params[:q])
    end
  end
end
