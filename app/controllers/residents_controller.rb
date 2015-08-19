class ResidentsController < ApplicationController
  decorates_assigned :resident
  before_action :authenticate_user!

  def index
    @residents = User.residents.order(:name)
  end

  def show
    @resident = User.find(params[:id])
    @roommates = User.roommates(@resident.id, @resident.unit.id) if @resident.unit
  end

  def me
    @resident = current_user
    authorize @resident, :update?
  end

  def update
    authorize current_user, :update?
    if current_user.update_attributes(permitted_attributes(current_user))
      flash[:success] = 'Your profile has been updated.'
      redirect_to residents_me_path
    else
      render :edit
    end
  end

  def aws_upload_callback
    authorize current_user, :update?
    image_url = "https://#{params[:bucket]}.s3.amazonaws.com/#{params[:key]}"
    current_user.image = image_url
    current_user.save

    flash[:success] = 'Your image has been updated.'
    redirect_to residents_me_path
  end

  protected

  def show_params
    params.require(:id)
  end
end
