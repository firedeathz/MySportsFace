require 'test_helper'

class MicropostsControllerTest < ActionController::TestCase

	def setup
		@user = users(:marcos)
		@micropost = microposts(:firsty)
	end

	test "should redirect create when not logged in" do
		assert_no_difference 'Micropost.count' do
			post :create, micropost: { content: "Test" }
		end
		assert_redirected_to login_url
	end
	
	test "should redirect delete when not logged in" do
		assert_no_difference 'Micropost.count' do
			delete :destroy, id: @micropost
		end
		assert_redirected_to login_url
	end
	
	test "should redirect delete when wrong user" do
		log_in_as(@user)
		micropost = microposts(:other_post_0)
		assert_no_difference 'Micropost.count' do
			delete :destroy, id: micropost
		end
		assert_redirected_to root_url
	end
end
