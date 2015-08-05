require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase
	
	def setup
		@user = users(:marcos)
		@org = organizations(:exampleorg)
		@article = articles(:clownfiesta)
	end

	test "should redirect show when not logged in" do
		get :show, id: @article.id
		assert_redirected_to login_url
		get :index, organization_id: @org.id
		assert_redirected_to login_url
	end

end
