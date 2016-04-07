class UserRecipe < ActiveRecord::Base
	belongs_to :user
	belongs_to :recipe

  def analytics
    @analytics = CodeplaceAnalytics.new(self.user)
  end

	def check_state
		if self.state == "half_complete"
			analytics.track_recipe_half_complete(self)
		elsif self.state == "complete"
			analytics.track_recipe_complete(self)
		elsif self.state == "started"
			analytics.track_recipe_started(self)
		end
	end
end
