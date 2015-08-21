class UnitsController < ApplicationController
  decorates_assigned :unit
  before_action :authenticate_user!
  before_action :set_unit, only: [:show, :edit, :update, :destroy]

  def index
    @units = Unit.all.decorate
  end

  def show
    @unit = @unit.decorate
  end

  protected

  # Use callbacks to share common setup or constraints between actions.
  def set_unit
    @unit = Unit.find(params[:id])
  end

  def show_params
    params.require(:id)
  end
end
