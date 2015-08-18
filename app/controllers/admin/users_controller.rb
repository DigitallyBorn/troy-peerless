class Admin::UsersController < ApplicationController
  before_filter :authenticate_user!
  decorates_assigned :user

  def index
    authorize User
    @users = User.owners_and_residents
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    @roles = User.roles
    @owns = @user.owns.map(&:unit).decorate
    @rents = @user.rents.map(&:unit).decorate
    authorize @user, :update?
    @units = Unit.all
  end

  def orphans
    authorize User
    @users = User.orphans
  end

  protected

  def show_params
    params.require(:id)
  end
end
