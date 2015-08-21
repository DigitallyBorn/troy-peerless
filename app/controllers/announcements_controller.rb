class AnnouncementsController < ApplicationController
  before_filter :authenticate_user!, :except => :preview
  before_action :set_announcement, only: [:edit, :update, :destroy]
  protect_from_forgery :except => :preview

  def new
    authorize Announcement

    @announcement = Announcement.new
  end

  def create
    @annoucement = Announcement.new(announcement_params)
    @annoucement.user = current_user
    authorize @annoucement, :new?

    respond_to do |format|
      if @annoucement.save
        format.html { redirect_to root_path, notice: 'Annoucement was successfully created.' }
        format.json { render :show, status: :created, location: @annoucement }
      else
        format.html { render :new }
        format.json { render json: @annoucement.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    authorize @announcement
  end

  def update
    authorize @announcement

    respond_to do |format|
      if @announcement.update(announcement_params)
        format.html { redirect_to root_path, notice: 'Announcement was successfully updated.' }
        format.json { render :show, status: :ok, location: @announcement }
      else
        format.html { render :edit }
        format.json { render json: @announcement.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @announcement

    @announcement.destroy

    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Announcement was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def preview
    rendered_text = Kramdown::Document.new(preview_params[:text]).to_html
    render json: { text: rendered_text }
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_announcement
    @announcement = Announcement.find(params[:id])
  end

  def announcement_params
    params.require(:announcement).permit(:publish_date, :title, :body)
  end

  def preview_params
    params.permit(:text)
  end
end
