require 'jwt'

class ApplicationController < ActionController::API 
    before_action :authenticate
    attr_accessor :current_user

    ALGORITHM = 'HS256'

        def encode(payload)
            JWT.encode(payload, auth_secret, ALGORITHM)
        end

        def decode(token)
            body = JWT.decode(token, auth_secret, true, { algorithm: ALGORITHM })[0]
            HashWithIndifferentAccess.new body
        rescue
            nil
        end
    

        def auth_secret
            ENV['AUTH_SECRET'] || Rails.application.secrets.secret_key_base
        end
    

        def logged_in?
            set_current_user
            !!@current_user
        end 

        def current_user
            @current_user 
        end

        def decoded_token
            if auth_header
              token = auth_header
              begin
                JWT.decode(token, auth_secret, true, algorithm: ALGORITHM) 
              rescue JWT::DecodeError
                nil
              end
            end
        end
    
        def set_current_user
            if has_valid_auth_type?
                user = User.find_by(id: decoded_token[0]['user_id'])
                if user 
                    @current_user = user 
                end 
            end 
        end 

        def authenticate
            unless logged_in?
                render json: {
                    success: false,
                    error: 'Invalid credentials'
                }, status: :unauthorized
            end 
        end 

    private 

        def auth_header 
            request.headers['Authorization'].to_s.scan(/Bearer (.*)$/).flatten.last
        end 

        def has_valid_auth_type?
            !!request.headers['Authorization'].to_s.scan(/Bearer/).flatten.first
        end 

    
end
