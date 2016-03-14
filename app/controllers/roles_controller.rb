class RolesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_role, only: [:show, :edit, :update, :destroy]
  before_action :parse_activities, only: [:create, :update]

  def index
    @roles = policy_scope(Role).page(params[:page])
    respond_with(@roles)
  end

  def show
    authorize @role
    respond_with(@role)
  end

  def new
    @role = Role.new
    authorize @role
    respond_with(@role)
  end

  def create
    @role = Role.new(role_params)
    authorize @role
    @role.save
    respond_with(@role)
  end

  def edit
    authorize @role
    respond_with(@role)
  end

  def update
    authorize @role
    @role.update(role_params)
    respond_with(@role)
  end

  def destroy
    authorize(@role)
    @role.destroy
    respond_with(@role)
  end

  private

  def parse_activities
    if params[:role]
      if params[:role][:activities]
        params[:role][:activities] = params[:role][:activities].split(" ")
      end
    end
  end

  def set_role
    @role = Role.find(params[:id])
  end

  def role_params    
    params.require(:role).permit(
      :name,
      activities: []
    )
  end
end
