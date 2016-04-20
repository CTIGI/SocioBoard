class SimulationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_simulation, only: [:show, :edit, :update, :destroy]

  def index
    @simulations = policy_scope(Simulation).where(user_id: current_user.id)
    respond_with(@simulations, layout: false)
  end

  def new_simulation
    @simulation = Simulation.new
    @simulation.generate_name
    @simulation.data = params[:extra][:table]
    @simulation.div_text = params[:extra][:div_text]
    authorize @simulation
    respond_with(@simulation, layout: false)
  end

  def create
    @simulation = Simulation.new(simulation_params)
    authorize @simulation
    status = @simulation.save ? 200 : 403
    respond_with(@simulation, layout: false, status: status)
  end

  def show
    authorize @simulation
    respond_with(@simulation, layout: false)
  end

  def edit
    authorize @simulation
    respond_with(@simulation, layout: false)
  end

  def update
    authorize @simulation
    status = @simulation.update(simulation_params) ? 200 : 403
    respond_with(@simulation, layout: false, status: status)
  end

  private
  def set_simulation
    @simulation = Simulation.find(params[:id])
  end

  def simulation_params
    params.require(:simulation).permit(
      :name,
      :data,
      :div_text,
      :user_id
    )
  end
end
