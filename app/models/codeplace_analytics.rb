class CodeplaceAnalytics

  def initialize(user)
    @user = user
  end

# User Info Tracking

  # def track_delete_account
  #   track(
  #     {
  #       user_id: user.id,
  #       event: 'Delete Account'
  #     }
  #   )
  # end

  def track_update_details
    track(
      {
        user_id: user.id,
        event: 'Updated Settings',
        timestamp: user.updated_at
      } 
    )
  end

# User Learning Tracking 

  # def section_complete(user_section)
  #   identify("learning")
  # end

  def track_recipe_started(user_recipe)
    track(
      {
        user_id: user.id,
        event: 'Recipe Started',
        properties: {
          recipe: user_recipe.recipe.name
        },
        timestamp: user_recipe.created_at
      }  
    )
  end

  def track_recipe_half_complete(user_recipe)
    track(
      {
        user_id: user.id,
        event: 'Recipe Half Complete',
        properties: {
          recipe: user_recipe.recipe.name
        },
        timestamp: user_recipe.updated_at
      }  
    )
  end

  def track_recipe_complete(user_recipe)
    track(
      {
        user_id: user.id,
        event: 'Recipe Complete',
        properties: {
          recipe: user_recipe.recipe.name
        },
        timestamp: user_recipe.updated_at
      }  
    )
  end


  # def track_favorite(recipe)
  #   identify("learning")
  # end

# User Billing Tracking 

  def track_start_trial
    track(
      {
        user_id: user.id,
        event: 'Trial Started',
        properties: {
          subsciption_id: "12345",
          plan: "Developer Plan"
        },
        timestamp: user.trial_started_at
      }
    )
  end

  def track_cancel_trial
    track(
      {
        user_id: user.id,
        event: 'Trial Canceled',
        timestamp: user.last_canceled_at
      }
    )
  end

  def track_activate
    track(
      {
        user_id: user.id,
        event: 'Activated',
        timestamp: user.activated_at
      }
    )
  end

  # def track_charge
  #   identify("billing")
  #   track(
  #     {
  #       user_id: user.id,
  #       event: 'Payment Made',
  #       properties: {
  #         subsciption_id: 12345,
  #         plan: "Developer",
  #         cycle: 'Monthly',
  #         revenue: 29
  #       }
  #     }
  #   )
  # end

  # def track_refund
  #   identify("billing")
  #   track(
  #   {
  #     user_id: user.id,
  #     event: 'Refund Made',
  #     properties: {
  #         subsciption_id: 12345,
  #         plan: "Developer",
  #         reason: 'Unknown',
  #         revenue: -29
  #       }
  #   }
  #   )
  # end

  def track_cancel
    identify
    track(
      {
        user_id: user.id,
        event: 'Subscription Canceled',
        timestamp: user.last_canceled_at
      }
    )
  end

  def track_reactivate
    track(
      {
        user_id: user.id,
        event: 'Subscription Reactivated',
        timestamp: user.last_reactivated_at
      }
    )
  end

  def track_user_signup
    track(
    {
      user_id: user.id,
      event: "Signed Up",
      timestamp: user.created_at
    }
      )
  end

  

  def identify
    Analytics.identify(
      user_id: user.id,
      traits: {
        # User Info
        id: user.id,
        name: "Tiago Martins",
        email: user.email,
        createdAt: user.created_at,
        newsletter_subscribed: user.newsletter_subscribed,
        # Billing
        trial_started_at: user.trial_started_at,
        trial_canceled_at: user.trial_canceled_at,
        activated_at: user.activated_at,
        last_reactivated_at: user.last_reactivated_at,
        last_canceled_at: user.last_canceled_at,
        subscription_state: user.aasm_state,
      }
    )
  end

  attr_reader :user, :anon_id

  def track(options)
    Analytics.track(options)
  end
  
end