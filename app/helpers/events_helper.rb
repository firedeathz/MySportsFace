module EventsHelper
	def month_name(month)
		case month
		when 1
			"January"
		when 2
			"February"
		when 3
			"March"
		when 4
			"April"
		when 5
			"May"
		when 6
			"June"
		when 7
			"July"
		when 8
			"August"
		when 9
			"September"
		when 10
			"October"
		when 11
			"November"
		when 12
			"December"
		end
	end
	
	def not_creator(user, event)
		!user.event_creator?(event)
	end
end
