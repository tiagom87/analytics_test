class RegistrationsController < Devise::RegistrationsController

def destroy
	analytics.track_delete_account
	super
end

protected

	def after_sign_up_path_for(resource)
		recipes_path(state: "signed_up")
	end

	def after_update_path_for(resource)
		analytics.track_update_details
    	super
  	end
end