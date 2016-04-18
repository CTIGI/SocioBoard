class AnalysisController < ApplicationController
  before_action :authenticate_user!
  skip_after_action :verify_policy_scoped
  skip_after_action :verify_authorized

  def unconformities
    @units = Unit.all
    @is_simulator = false
  end

  def simulator
    @units = Unit.all
    @is_simulator = true
  end

  def load_simulator_modal
    @origin_unit = params[:origin_unit].to_i
    @units = Unit.where.not(id: @origin_unit)
    @age = params[:age].to_i
    @measure_type = params[:measure_type]
    @unit_measure = params[:unit_measure]
    @current_value = params[:extra].to_i
    respond_with(@units, layout: false)
  end

  def update_table
    @origin_unit = Unit.find(params["/analysis/update_table"][:origin_unit])
    @unit = Unit.find(params["/analysis/update_table"][:unit])
    @age = params["/analysis/update_table"][:age]
    @measure_type = params["/analysis/update_table"][:measure_type]
    @unit_measure = params["/analysis/update_table"][:unit_measure]
    @to_update = params["/analysis/update_table"][:current_value].to_i
    @old_value = params["/analysis/update_table"][:old_value].to_i
    @target_cell_value = params[:target_cell_value].to_i
    @origin_occupation = params[:origin_occupation].to_i - @to_update
    @target_occupation = params[:target_occupation].to_i + @to_update
    @text_simulator_in = I18n.t("views.analysis.simulator_movements_in", value: @to_update,
                              origin: @origin_unit.name, age: @age, measure: @measure_type)
    @text_simulator_out = I18n.t("views.analysis.simulator_movements_out", value: @to_update,
                                target: @unit.name, age: @age, measure: @measure_type)
  end

end
