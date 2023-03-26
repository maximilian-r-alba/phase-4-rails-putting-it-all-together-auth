class SessionsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_error
skip_before_action :authorize, only: :create

    def create
        user = User.find_by!(username: params[:username])
        if user&.authenticate(params[:password])
            session[:user_id] = user.id
            render json: user
        else
            render json:{error:[ "Username or password is invalid"]}, status: :unauthorized
        end
    end

    def destroy
        if session.include? :user_id
        session.delete :user_id
        head :no_content
        else
            render json: {errors:["User is not logged in"]} , status: :unauthorized
        end
    end

    private

    def render_not_found_error(invalid)
        
        render json: {errors: ["Couldn't find user"]}, status: :unauthorized
    end

end
