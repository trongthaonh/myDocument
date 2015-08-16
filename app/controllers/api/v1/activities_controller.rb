class API::V1::ActivitiesController < ApplicationController
  before_action :set_activity, only: [:show, :destroy]
  load_and_authorize_resource
  
  # GET /api/v1/activities
  # GET /api/v1/activities?user_id = 1
  def index
    if current_user.admin?
      @activities = Activity.all
      @activities = @activities.where(:owner_id => params[:user_id]) if params[:user_id]
    else
      @activities = Activity.where(:owner_id => current_user.id)
    end
  end

  # GET /api/v1/activities/1
  def show
  end

  # DELETE /api/v1/activities/1
  def destroy
    @log.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      begin
        @activity = Activity.find(params[:id])
      rescue Exception => e
        @error = e.message
        render :json => {:error => @error}
      end
    end
end
