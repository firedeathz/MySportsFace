require 'test_helper'

class EventsInterfaceTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:marcos)
		@event = events(:mexicana)
	end
	
	test "event creation" do
		log_in_as(@user)
		get events_new_path
		assert_no_difference 'Event.count' do
			post events_path, event: { user_id: 1000, name: "invalid", description: "derp", summary: "herp", location: "location", date: "2-2-2000", time: "00:00" }
		end
		assert_difference 'Event.count', 1 do
			post events_path, event: { user_id: 1000, name: "very valid event", description: "derp", summary: "herp", location: "Lisboa", date: "2-2-2000", time: "00:00", lat: "000", lng: "000" }
		end
	end
	
	test "star and unstar an event" do
		log_in_as(@user)
		get event_path(@event)
		assert_difference '@event.votes_for', 1 do
			post star_event_path(@event)
		end
		assert_difference '@event.votes_for', -1 do
			post unstar_event_path(@event)
		end
	end
	
	test "should not allow uploads when not logged in and signed up" do
		get event_path(@event)
		assert_no_difference 'Picture.count' do
			post event_pictures_path(@event), picture: { event_id: @event, url: "http://www.random.org/random.png" }
		end
		assert_no_difference 'Video.count' do
			post event_videos_path(@event), video: { event_id: @event, url: "https://www.youtube.com/watch?v=tlfQqqnk9sI" }
		end
	end
	
end
