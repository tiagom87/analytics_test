 class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  	def start_trial
  		@user.start_trial
      @user.save
  		redirect_to edit_user_registration_path(state: "trial_started", email: @user.email, revenue: 29), notice: 'Trial Started'
  	end

  	def cancel_trial
  		@user.cancel_trial
      @user.save
  		redirect_to edit_user_registration_path(state: "trial_canceled"), notice: 'Trial Canceled'
  	end

  	def activate
  		@user.activate
      @user.save
  		redirect_to edit_user_registration_path(state: "subscription_canceled"), notice: 'Subscription Active'
  	end

  	def cancel
  		@user.cancel
      @user.save
  		redirect_to edit_user_registration_path(state: "subscription_canceled"), notice: 'Subscription Canceled'
  	end

  	def reactivate
  		@user.reactivate
      @user.save
  		redirect_to edit_user_registration_path(state: "subscription_reactivated"), notice: 'Subscription Reactivated'
  	end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end
 end