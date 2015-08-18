class Admin::UsersController < ApplicationController
  before_filter :authenticate_user!
  decorates_assigned :user

  def index
    authorize User
    @users = User.all
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

  protected

  def show_params
    params.require(:id)
  end
end
