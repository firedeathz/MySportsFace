require 'test_helper'

class MicropostsInterfaceTest < ActionDispatch::IntegrationTest
	
	def setup
		@user = users(:marcos)
	end
	
	test "micropost interface" do
		# Log in
		log_in_as(@user)
		get root_path
		assert_select 'div.pagination'
		# Attempt to create an invalid post
		assert_no_difference 'Micropost.count' do
			post microposts_path, micropost: { content: " " }
		end
		assert_select 'div#error_explanation'
		# Create a valid post
		content = "Nice posterino"
		assert_difference 'Micropost.count', 1 do
			post microposts_path, micropost: { content: content }
		end
		assert_redirected_to root_url
		follow_redirect!
		assert_match content, response.body
		# Delete a post
		assert_select 'a', text: 'delete'
		first_post = @user.microposts.paginate(page: 1).first
		assert_difference 'Micropost.count', -1 do
			delete micropost_path(first_post)
		end
		# Visit another user and check if posts can be deleted
		get user_path(users(:otherguy))
		assert_select 'a', text: 'delete', count: 0
	end
	
	test "star and unstar a micropost" do
		log_in_as(@user)
		get root_path
		post = @user.microposts.paginate(page: 1).first
		assert_difference 'post.votes_for', 1 do
			post star_micropost_path(post)
		end
		assert_difference 'post.votes_for', -1 do
			post unstar_micropost_path(post)
		end
	end
	
end
