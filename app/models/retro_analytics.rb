class RetroAnalytics

	def load_users
		User.all.each do |u|
			c = CodeplaceAnalytics.new(u)
			c.identify
		end
	end

	def load_billing_events
	end

	def load_learning_events
	end
end