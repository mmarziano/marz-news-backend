class Api::V1::SessionsController < ApplicationController
    skip_before_action :authenticate, only: [:create, :google]

    def create
        @user = User.find_by(email: login_params[:email])
            if @user && @user.authenticate(login_params[:password]) 
                jwt = encode({user_id: @user.id})
                render json: {
                    success: true,
                    user: @user,
                    token: jwt
                }, status: :created and return
            else
                render json: {
                    success: false,
                    error: 'Invalid Credentials'
                }, status: :unauthorized and return
            end
    end 

    def google
        @user = User.find_by(email: google_params[:email])
            if @user 
                jwt = encode({user_id: @user.id})
                render json: {
                    success: true,
                    user: @user,
                    token: jwt
                }, status: :created and return
            elsif @user = User.new(google_params)
                if @user.save
                    jwt = encode({user_id: @user.id})
                    render json: {
                    success: true,
                    user: @user,
                    token: jwt
                }, status: :created and return
                end
            else
                render json: {
                    success: false,
                    error: 'Invalid Credentials'
                }, status: :unauthorized and return
            end
        # @user = User.find_by(email: google_params[:email])
        # if @user 
        #     log_in(@user)
        #     render json: @user
        # else @user = User.new(google_params)
        #     if @user.save
        #         log_in(@user)
        #         render json: @user
        #     else
        #         render json: {:errors => @user.errors.full_messages}, status: 422
        #     end
        # end
        
    end

    private
    
    def login_params
        params.require(:user).permit(:email, :password)
    end

    def google_params
        params.require(:user).permit(:email, :first_name, :last_name, :password, :oauthID, :profileImg)
    end
end