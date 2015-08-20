class DocumentsController < ApplicationController
  decorates_assigned :document
  before_action :set_document, only: [:show, :edit, :update, :destroy]

  include AwsHelper

  # GET /documents
  # GET /documents.json
  def index
    @documents = Document.all.decorate
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
    redirect_to presigned_download_url(URI(@document.url).path.gsub(/^\//,''))
  end

  # GET /documents/new
  def new
    @post = presigned_document_upload()
  end

  # GET /documents/1/edit
  def edit
  end

  # POST /documents
  # POST /documents.json
  def create
    @document = Document.new(document_params)

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

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to @document, notice: 'Document was successfully updated.' }
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { render :edit }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document.destroy
    respond_to do |format|
      format.html { redirect_to documents_url, notice: 'Document was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def aws_callback
    @document = Document.new()
    @document.url = "https://#{params[:bucket]}.s3.amazonaws.com/#{params[:key]}"
    @document.user = current_user
    @document.title = params[:title]
    @document.category = Document.categories[params[:category]]

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
