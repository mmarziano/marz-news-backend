class Api::V1::SessionsController < ApplicationController
    
    def index
        @user = User.new
    end

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

        redirect_to '/'
    end 

    def omniauth
        @user = User.from_omniauth(auth)
        @user.save
        session[:user_id] = @user.id
        if @user.household_id == nil
            render '/users/complete_profile', layout: "main"
        else 
            redirect_to user_path(@user)
        end 
    end

    private
    
    def login_params
        params.require(:user).permit(:email, :password)
    end

    def auth
        request.env['omniauth.auth']
    end
end