require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
	include ApplicationHelper
	
	def setup
		@user = users(:marcos)
	end
	
	test "profile display" do
		log_in_as(@user)
		get user_path(@user)
		assert_template 'users/show'
		assert_select 'title', full_title("Profile")
		assert_select 'h1.username>a', text: @user.name
		assert_select 'a>img.gravatar'
		assert_match @user.microposts.count.to_s, response.body
		assert_select 'div.pagination'
	end
	
end
