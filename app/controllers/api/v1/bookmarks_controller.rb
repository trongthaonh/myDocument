class API::V1::BookmarksController < ApplicationController
  before_action :set_bookmark, only: [:show, :update, :destroy]
  load_and_authorize_resource
  
  # GET /api/v1/bookmarks
  # GET /api/v1/bookmarks?user_id=1
  def index
    if current_user.admin?
      @bookmarks = Bookmark.all
      @bookmarks = @bookmarks.where(:user_id => params[:user_id]) if params[:user_id]
    else
      @bookmarks = current_user.bookmarks
    end
  end

  # GET /api/v1/bookmarks/1
  def show
  end


  # POST /api/v1/bookmarks
  def create
    @bookmark = Bookmark.new(bookmark_params)
    respond_to do |format|
      if @bookmark.save
        format.json { render :show, status: :created}
      else
        format.json { render json: @bookmark.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /api/v1/bookmarks/1
  def update
    respond_to do |format|
      if @bookmark.update(bookmark_params)
        format.json { render :show, status: :ok}
      else
        format.json { render json: @bookmark.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api/v1/bookmarks/1
  def destroy
    @bookmark.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bookmark
      begin
        @bookmark = Bookmark.find(params[:id])
      rescue Exception => e
        @error = e.message
        render :json => {:error => @error}
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bookmark_params
      params.require(:bookmark).permit(:color, :document_id, :user_id)
    end
end
