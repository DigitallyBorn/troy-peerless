class IssuesController < ApplicationController
  before_action :authenticate_user!
  decorates_assigned :issue
  decorates_assigned :issues
  before_action :set_issue, only: [:show, :edit, :update, :close, :add_comment]

  def index
    @issues = policy_scope(Issue).order(updated_at: :desc)
  end

  def show
    authorize @issue

    @events = (@issue.comments + @issue.events).sort!{|a,b| a.created_at <=> b.created_at}
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

  def close
    authorize @issue
    @issue.close!(current_user)

    respond_to do |format|
      format.html { redirect_to issue_path(@issue.id), notice: 'Issue was closed.' }
      format.json { render :show, status: :created }
    end
  end

  def add_comment
    authorize @issue
    comment = IssueComment.new(user: current_user, issue: @issue)
    comment.update_attributes(add_comment_params)

    respond_to do |format|
      if comment.save
        format.html { redirect_to issue_path(@issue.id), notice: 'Issue comment was successfully created.' }
        format.json { render :show, status: :created }
      else
        format.html { render :new }
        format.json { render json: comment.errors, status: :unprocessable_entity }
      end
    end
  end

  protected

  def set_issue
    @issue = policy_scope(Issue).find(params[:id])
  end

  def show_params
    params.require(:id)
  end

  def add_comment_params
    params.require(:issue_comment).permit(:body)
  end
end
