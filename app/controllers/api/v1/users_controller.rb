class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  # skip_before_action :authorized, only: [:update, :destroy]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
          log_in(@user)
          render json: current_user
    else
      render json: {:errors => @user.errors.full_messages}, status: 422 
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      byebug
      render json: @user
    else
      render json: {:errors => @user.errors.full_messages}, status: 422
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:email, :password, :first_name, :last_name, :oauthID, :profileImg, {:preferences_categories => []}, :preferences_language)
    end
end
