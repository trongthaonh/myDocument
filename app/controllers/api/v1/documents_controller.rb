class API::V1::DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :update, :destroy]
  load_and_authorize_resource
  
  # GET /api/v1/documents
  def index
    if current_user.admin?
      @documents = Document.all
    else
      @projects = current_user.projects
      @documents = []
      @projects.each do |project|
        unless project.documents.empty?
          project.documents.each do |document|
            @documents.push document
          end
        end
      end
    end
  end

  # GET /api/v1/documents/1
  def show
  end


  # POST /api/v1/documents
  def create
    @document = Document.new(document_params)
    respond_to do |format|
      if @document.save
        format.json { render :create, status: :created}
      else
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /api/v1/documents/1
  def update
    respond_to do |format|
      if @document.update(document_params)
        format.json { render :show, status: :ok}
      else
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api/v1/documents/1
  def destroy
    @document.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      begin
        @document = Document.find(params[:id])
      rescue Exception => e
        @error = e.message
        render :json => {:error => @error}
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      params.require(:document).permit(:name, :content, :comment, :tag, :file, :project_id)
    end
end
