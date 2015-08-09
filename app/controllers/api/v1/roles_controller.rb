class API::V1::RolesController < ApplicationController
  before_action :set_role, only: [:show, :update, :destroy]
  load_and_authorize_resource
  
  # GET /api/v1/roles
  def index
    if current_user.admin?
      @roles = Role.all
    else
      @roles = current_user.roles
    end
  end

  # GET /api/v1/roles/1
  def show
  end


  # POST /api/v1/roles
  def create
    @role = Role.new(role_params)

    respond_to do |format|
      if @role.save
        format.json { render :show, status: :created}
      else
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /api/v1/roles/1
  def update
    respond_to do |format|
      if @role.update(role_params)
        format.json { render :show, status: :ok}
      else
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api/v1/roles/1
  def destroy
    @role.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  def get_users
    begin
      @role = Role.find(params[:role_id])
      @users = @role.users
      render :json=> {:users => @users}, :status => 200
    rescue Exception => e
      @error = e.message
      render :json => {:error => @error}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_role
      begin
        @role = Role.find(params[:id])
      rescue Exception => e
        @error = e.message
        render :json => {:error => @error}
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def role_params
      params.require(:role).permit(:name, :description)
    end
end
