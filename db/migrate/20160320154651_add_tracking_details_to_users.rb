class AddTrackingDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :newsletter_subscribed, :boolean, default: true
    add_column :users, :sections_completed_count, :integer, default: 0
    add_column :users, :recipes_started_count, :integer, default: 0
    add_column :users, :recipes_half_completed_count, :integer, default: 0
    add_column :users, :recipes_completed_count, :integer, default: 0
    add_column :users, :favorite_count, :integer, default: 0
    add_column :users, :trial_started_at, :datetime
    add_column :users, :trial_canceled_at, :datetime
    add_column :users, :activated_at, :datetime
    add_column :users, :last_reactivated_at, :datetime
    add_column :users, :last_canceled_at, :datetime
    add_column :users, :charge_count, :integer, default: 0
    add_column :users, :refund_count, :integer, default: 0
  end
end
