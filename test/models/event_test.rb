require 'test_helper'

class EventTest < ActiveSupport::TestCase

	def setup
		@user = users(:marcos)
		@event = events(:mexicana)
	end

	test "should be valid" do
		assert @event.valid?
	end
	
	test "name should be at least 8 characters" do
		@event.name = "a" * 7
		assert_not @event.valid?
	end
	
	test "summary should be maximum 255 characters" do
		@event.summary = "a" * 256
		assert_not @event.valid?
	end
	
	test "summary should be present" do
		@event.summary = nil
		assert_not @event.valid?
	end
	
	test "user_id should be present" do
		@event.user_id = nil
		assert_not @event.valid?
	end
	
	test "name should be present" do
		@event.name = nil
		assert_not @event.valid?
	end
	
	test "description should be present" do
		@event.description = nil
		assert_not @event.valid?
	end
	
	test "location should be present" do
		@event.location = nil
		assert_not @event.valid?
	end
	
	test "time should be present" do
		@event.time = nil
		assert_not @event.valid?
	end
	
	test "date should be present" do
		@event.date = nil
		assert_not @event.valid?
	end
	
end
