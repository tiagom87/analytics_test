class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

  has_many :user_recipes, dependent: :destroy
  has_many :recipes, through: :user_recipes

   def analytics
    @analytics = CodeplaceAnalytics.new(self)
  end

  include AASM

  aasm do
  	state :signed_up, :initial => true
  	state :trial
  	state :active
  	state :canceled

  	event :start_trial do
      before do
        self.update_attributes(trial_started_at: Time.now)
        analytics.track_start_trial
      end
  		transitions :from => :signed_up, :to => :trial
  	end

  	event :cancel_trial do
      before do 
        self.update_attributes(trial_canceled_at: Time.now)
        analytics.track_cancel_trial
      end
  		transitions :from => :trial, :to => :canceled
  	end

  	event :activate do 
      before do 
        self.update_attributes(activated_at: Time.now)
        analytics.track_activate
      end
  		transitions :from => :trial, :to => :active
  	end

  	event :cancel do 
      before do 
        self.update_attributes(last_canceled_at: Time.now)
        analytics.track_cancel
      end
  		transitions :from => :active, :to => :canceled
  	end

  	event :reactivate do
      before do 
        self.update_attributes(last_reactivated_at: Time.now)
        analytics.track_reactivate
      end
  		transitions :from => :canceled, :to => :active
  	end

  end
end
