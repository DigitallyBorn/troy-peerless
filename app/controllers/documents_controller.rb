class DocumentsController < ApplicationController
  before_filter :authenticate_user!
  decorates_assigned :document
  before_action :set_document, only: [:show, :edit, :update, :destroy]

  include AwsHelper

  # GET /documents
  # GET /documents.json
  def index
    authorize Document
    @categories = Document.all.order(:title).decorate.group_by(&:category)
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
    authorize @document, :show?
    redirect_to Aws::S3::Object.new(@document.s3_bucket, @document.s3_key).presigned_url(:get)
  end

  # GET /documents/new
  def new
    authorize Document
    @post = presigned_document_upload()
  end

  # POST /documents
  # POST /documents.json
  def create
    @document = Document.new(document_params)

    authorize @user, :create?

    respond_to do |format|
      if @document.save
        format.html { redirect_to @document, notice: 'Document was successfully created.' }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { render :new }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    authorize @document, :destroy?

    Aws::S3::Object.new(@document.s3_bucket, @document.s3_key).delete

    @document.destroy
    respond_to do |format|
      format.html { redirect_to documents_url, notice: 'Document was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def aws_callback
    @document = Document.new()
    @document.user = current_user
    @document.title = params[:title]
    @document.category = params[:category]

    @document.s3_key = params[:key]
    @document.s3_bucket = params[:bucket]
    @document.url = Aws::S3::Object.new(@document.s3_bucket, @document.s3_key).public_url

    respond_to do |format|
      if @document.save
        format.html { redirect_to documents_url, notice: 'Document was successfully created.' }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { render :new }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      params.require(:document).permit(:title, :url, :user_id, :category)
    end

    def callback_params
      params.require(:title)
      params.require(:category)
      params.require(:bucket)
      params.require(:key)
    end
end
