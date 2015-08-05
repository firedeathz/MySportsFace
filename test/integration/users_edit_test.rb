require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
 
	def setup
		@user = users(:marcos)
	end
	
	test "successful edit with friendly forwarding" do
		# Must be logged in to try and edit profile
		get edit_user_path(@user)
		log_in_as(@user)
		assert_redirected_to edit_user_path(@user)
		name = "Marcos"
		email = "mikazzz_pro@hotmail.com"
		patch user_path(@user), user: { name: name, email: email, password: "12345678", password_confirmation: "12345678" }
		assert_not flash.empty?
		assert_redirected_to @user
		@user.reload
		assert_equal name, @user.name
		assert_equal email, @user.email
	end
	
	test "failed edit" do
		# Must be logged in to try and edit profile
		log_in_as(@user)
		get edit_user_path(@user)
		assert_template 'users/edit'
		patch user_path(@user), user: { name: "", email: "foo@invalid", password: "foo", password_confirmation: "bar" }
		assert_template 'users/edit'
	end
 
end
