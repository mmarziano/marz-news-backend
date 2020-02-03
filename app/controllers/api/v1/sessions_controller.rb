class Api::V1::SessionsController < ApplicationController
    
    def index
        @user = User.new
    end

    def new
        @user=User.new
    end 

    def create
        @user = User.find_by(email: params[:email])
            if @user && @user.authenticate(params[:password])&& @user.school_id != nil
                log_in(@user)
                redirect_to user_path(@user)
            elsif @user && @user.authenticate(params[:password])
                redirect_to signup_path(@user)
            elsif @user 
                render "sessions/login_retry"
            else 
                redirect_to new_user_path
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
    
    def auth
        request.env['omniauth.auth']
    end
end