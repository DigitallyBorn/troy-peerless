class ResidentsController < ApplicationController
  decorates_assigned :resident
  before_action :authenticate_user!

  def index
    @residents = User.owners_and_residents
  end

  def show

  end

  def me
  end

  def update
  end

  protected

  def show_params
    params.require(:id)
  end
end
