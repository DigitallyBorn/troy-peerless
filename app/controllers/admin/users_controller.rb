class Admin::UsersController < ApplicationController
  before_filter :authenticate_user!
  decorates_assigned :users, with: Admin::UserDecorator
  before_action :set_user, only: [
                                  :show,
                                  :edit,
                                  :update,
                                  :destroy,
                                  :add_unit,
                                  :make_admin,
                                  :make_board_member,
                                  :make_normal
                                ]

  def index
    authorize User
    @users = User.includes(:owns, :unit).all
  end

  def edit
    authorize @user, :update?
    @roles = User.roles
    @units = Unit.all
  end

  def update
    authorize @user, :update?
    if @user.update_attributes(permitted_attributes(@user))
      flash[:success] = "#{@user.name} has been updated."
      redirect_to edit_admin_user_path(@user)
    else
      render :edit
    end
  end

  def add_unit
    authorize @user, :update?

    @user.owns << Unit.find_by_number(params[:unit][:number])
    flash[:success] = "#{params[:unit][:number]} has been added."
    redirect_to edit_admin_user_path(@user)
  end

  def remove_unit
    authorize @user, :update?
    unit = Unit.find_by_number(params[:unit_id])
    @user.owns.destroy(unit)
    flash[:success] = "#{unit.number} has been removed."
    redirect_to edit_admin_user_path(@user)
  end

%w(admin board_member normal).each do |role|
  define_method("make_#{role}") do
    authorize @user, :change_role?
    @user.send("#{role}!")
    flash[:success] = "#{@user.name} is now a #{role}."
    redirect_to edit_admin_user_path(@user)
  end
end



  protected

  def set_user
    @user = User.find(params[:id])
  end

  def show_params
    params.require(:id)
  end

  def update_params
    params.require(:id).permit(policy(@user).permitted_attributes)
  end
end
