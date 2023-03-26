class UsersController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_error
skip_before_action :authorize, only: :create
    def create
        user = User.create!(user_params)
        render json: user, status: :created
    end

    # def show

    # end

    private
    
    def render_unprocessable_error(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

    def user_params
        params.permit(:username, :password, :image_url, :bio)
    end
end
