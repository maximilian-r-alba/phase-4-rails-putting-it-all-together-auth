class RecipesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_error

    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_error

    def index
       render json: Recipe.all
    end

    def create
        recipe = @current_user.recipes.create!(recipe_params)
        render json: recipe, status: :created
    end


    private

    def render_not_found_error(invalid)
        
        render json: {errors: ["Couldn't find user"]}, status: :unauthorized
    end

    def render_unprocessable_error(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete)
    end

end
