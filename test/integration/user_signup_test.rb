require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest

	test "invalid signup info" do
		get signup_path
		assert_no_difference 'User.count' do
			post users_path, user: { name: 					"",
									 email: 				"user@invalid",
									 password: 				"1234567",
									 password_confirmation: "7654321" }
		end
		assert_template 'users/new'
	end
	
	test "valid signup info" do
		get signup_path
		assert_difference 'User.count', 1 do
			post_via_redirect users_path, user: { name: 					"TestUser",
												  email: 					"test@mysportsface.com",
												  password:					"12345678",
												  password_confirmation:	"12345678" }
		end
		assert_template 'users/show'
	end
end
