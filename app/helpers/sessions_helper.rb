module Api::SessionsHelper

    # Logs in the given user.
    def log_in(user)
        session[:user_id] = user.id
      end
    
      # Returns the current logged-in user (if any).
      def current_user
        if session[:user_id]
          @current_user ||= User.find_by(id: session[:user_id])
        end
      end
    
      # Returns true if the user is logged in, false otherwise.
      def logged_in?
        !current_user.nil?
      end

      def logout_user(user)
        if session[:user_id] == user.id 
          session[:user_id] = nil 
        end
      end 

      # Returns true if the user is an admin.

      def authorized
        render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
      end
      
end