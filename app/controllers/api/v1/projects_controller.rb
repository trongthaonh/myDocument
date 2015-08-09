class API::V1::ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :update, :destroy]
  load_and_authorize_resource
  
  # GET /api/v1/projects
  def index
    if current_user.admin?
      @projects = Project.all
    else
      @projects = current_user.projects
    end
  end

  # GET /api/v1/projects/1
  def show
  end


  # POST /api/v1/projects
  def create
    @project = current_user.projects.build(project_params)

    respond_to do |format|
      if @project.save
        format.json { render :show, status: :created}
      else
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /api/v1/projects/1
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.json { render :show, status: :ok}
      else
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api/v1/projects/1
  def destroy
    @project.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      begin
        @project = Project.find(params[:id])
      rescue Exception => e
        @error = e.message
        render :json => {:error => @error}
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :comment)
    end
end
