class SessionsController < Devise::SessionsController

	protected

	def after_sign_in_path_for(resource)
		recipes_path(state: "signed_in")
	end

end