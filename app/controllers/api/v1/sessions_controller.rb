class Api::V1::SessionsController < ApplicationController
    
    def new
        @user=User.new
    end 

    def create
        @user = User.find_by(email: login_params[:email])
            if @user && @user.authenticate(login_params[:password]) 
                log_in(@user)
                render json: current_user
            else
                render json: { message: 'Unable to login' }
            end
    end 


    def destroy 
        session[:user_id] = nil
    end 

    def google
        @user = User.find_by(email: google_params[:email])
        if @user 
            log_in(@user)
            render json: current_user
        else @user = User.new(google_params)
            if @user.save
                log_in(@user)
                render json: current_user
            else
                render json: {:errors => @user.errors.full_messages}, status: 422
            end
        end
        
    end

    private
    
    def login_params
        params.require(:user).permit(:email, :password)
    end

    def google_params
        params.require(:user).permit(:email, :first_name, :last_name, :password, :oauthID, :profileImg)
    end
end