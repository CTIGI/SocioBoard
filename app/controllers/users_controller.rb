class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = policy_scope(User).page(params[:page])
    respond_with(@users)
  end

  def new
    @user = User.new
    authorize @user
    respond_with(@user)
  end

  def create
    @user = User.new(user_params)
    authorize @user
    @user.save
    respond_with(@user)
  end

  def show
    authorize @user
    respond_with(@user)
  end

  def edit
    authorize @user
    respond_with(@user)
  end

  def update
    authorize @user
    @user.update(user_params)
    respond_with(@user)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :password,
      :email,
      role_ids: []
    )
  end
end
