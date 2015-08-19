class Admin::UsersController < ApplicationController
  before_filter :authenticate_user!
  decorates_assigned :user

  def index
    authorize User
    @users = User.all.order(:name)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    @roles = User.roles
    authorize @user, :update?
    @units = Unit.all
  end

  def update
    @user = User.find(params[:id])
    authorize @user, :update?
    if @user.update_attributes(permitted_attributes(@user))
      flash[:success] = "#{@user.name} has been updated."
      redirect_to edit_admin_user_path(@user)
    else
      render :edit
    end
  end

  def add_unit
    @user = User.find(params[:id])
    authorize @user, :update?

    @user.owns << Unit.find_by_number(params[:unit][:number])
    flash[:success] = "#{params[:unit][:number]} has been added."
    redirect_to edit_admin_user_path(@user)
  end

  def remove_unit
    @user = User.find(params[:id])
    authorize @user, :update?
    unit = Unit.find_by_number(params[:unit_id])
    @user.owns.destroy(unit)
    flash[:success] = "#{unit.number} has been removed."
    redirect_to edit_admin_user_path(@user)
  end

  protected

  def show_params
    params.require(:id)
  end

  def update_params
    params.require(:id).permit(policy(@user).permitted_attributes)
  end
end
