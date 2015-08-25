class IssuesController < ApplicationController
  before_action :authenticate_user!
  decorates_assigned :issue
  decorates_assigned :issues
  before_action :set_issue, only: [:show, :edit, :update, :destroy]

  def index
    @issues = policy_scope(Issue).order(updated_at: :desc)
  end

  def show
    authorize @issue
  end

  def new
    @issue = Issue.new unit: current_user.unit
  end

  def create
    @issue = Issue.new user: current_user
    @issue.update_attributes(permitted_attributes(@issue))

    respond_to do |format|
      if @issue.save
        format.html { redirect_to issues_path, notice: 'Issue was successfully created.' }
        format.json { render :show, status: :created, location: @issue }
      else
        format.html { render :new }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @issue
  end

  protected

  def set_issue
    @issue = policy_scope(Issue).find(params[:id])
  end

  def show_params
    params.require(:id)
  end
end
