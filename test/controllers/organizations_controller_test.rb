require 'test_helper'

class OrganizationsControllerTest < ActionController::TestCase
	
	def setup
		@user = users(:marcos)
		@org = organizations(:exampleorg)
	end

	test "should redirect index and organization page when not logged in" do
		get :index
		assert_redirected_to login_url
		get :show, id: @org.id
		assert_redirected_to login_url
	end

end
