	class UserRecipesController < ApplicationController
	before_action :authenticate_user!
	before_action :set_user_recipe, only: [:update, :destroy]

	def create
		@user_recipe = current_user.user_recipes.create(recipe_id: params[:recipe_id])
		respond_to do |format|
			if @user_recipe.save
				@user_recipe.check_state
				format.html { redirect_to @user_recipe.recipe, notice: 'Recipe was successfully started.' }
			else
				format.html { redirect_to @user_recipe.recipe, notice: 'Something went wrong' }
			end
		end
	end

	def update
		respond_to do |format|
			if @user_recipe.update(state: params[:state])
				@user_recipe.check_state
				format.html { redirect_to @user_recipe.recipe, notice: 'Recipe was successfully updated.' }
			else
				format.html { redirect_to @user_recipe.recipe, notice: 'Something went wrong' }
			end
		end
	end

	def destroy
		@user_recipe.destroy
		respond_to do |format|
			format.html { redirect_to @user_recipe.recipe, notice: 'Progress was reset' } 
		end
	end

	private

    # Use callbacks to share common setup or constraints between actions.
    def set_user_recipe
    	@user_recipe = UserRecipe.find(params[:user_recipe])
    end

end