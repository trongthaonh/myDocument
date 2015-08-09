class RegistrationsController < Devise::RegistrationsController
  before_action :set_user, only: [:show, :update]

  # GET /api/v1/users
  def index
    if current_user.admin?
      @users = User.all
    else
      @users = current_user
    end

    render :json=> {:users => @users}, :status => 200
  end

  # GET /api/v1/users/1
  def show
    render :json=> {:user => @user}, :status => 200
  end

  # PATCH/PUT /api/v1/users/1
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.json { render :show, status: :ok}
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end  

  # POST /users
  def create
    if existed_user?
      render :json => {:error => "Your email address is already in use"}
    else
      @user = User.create(user_params)

      if @user.save
        render :json => {:state => {:code => 0}, :data => @user }
      else
        render :json => {:state => {:code => 1, :messages => @user.errors.full_messages} }
      end
    end
  end
  

  private

    def set_user
      begin
        @user = User.find(params[:id])
      rescue Exception => e
        @error = e.message
        render :json => {:error => @error}
      end
    end

    def existed_user?
      begin
        @user = User.where(:email => params[:user][:email]).first
        !@user.nil?
      rescue Exception => e
        @error = e.message
        render :json => {:error => @error}
      end
    end

    def user_params
      params.require(:user).permit(:username, :email, :password, :admin, :role_id)
    end  
end
