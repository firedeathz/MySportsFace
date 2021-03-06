require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  
	def setup
		@user = users(:marcos)
		@post = @user.microposts.build(content: "Testing content")
	end
	
	test "should be valid" do
		assert @post.valid?
	end
	
	test "user id should be present" do
		@post.user_id = nil
		assert_not @post.valid?
	end
	
	test "content should not be blank" do
		@post.content = " "
		assert_not @post.valid?
	end
	
	test "content should be max 140 characters" do
		@post.content = "a" * 141
		assert_not @post.valid?
	end
  
	test "order should be most recent first" do
		assert_equal microposts(:post_0), @user.microposts.first
	end
  
end
