require 'test_helper'

class UserTest < ActiveSupport::TestCase

	def setup
		@user = User.new(name: "TestUser", email: "test@mysportsface.com", password: "12345678", password_confirmation: "12345678")
	end

	test "should be valid" do
		assert @user.valid?
	end
	
	test "name cannot be blank" do
		@user.name = " "
		assert_not @user.valid?
	end
	
	test "name should not be too long" do
		@user.name = "a" * 51
		assert_not @user.valid?
	end
	
	test "email should not be too long" do
		@user.email = "a" * 244 + "@mysportsface.com"
		assert_not @user.valid?
	end
	
	test "email should be valid" do
		valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
		valid_addresses.each do |email|
			@user.email = email
			assert @user.valid?, "#{valid_addresses.inspect} should be valid"
		end
	end
	
	test "email validation should reject invalid addresses" do
		invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
		invalid_addresses.each do |invalid_address|
			@user.email = invalid_address
			assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
		end
	end
	
	test "email addresses should be saved as lower-case" do
		mixed_case_email = "tEsT@MysPoRTsFAcE.CoM"
		@user.email = mixed_case_email
		@user.save
		assert_equal mixed_case_email.downcase, @user.reload.email
	end
	
	test "email should be unique" do
		duplicate = @user.dup
		duplicate.email = @user.email.upcase
		@user.save
		assert_not duplicate.valid?
	end
	
	test "password must be present" do
		@user.password = " " * 8
		assert_not @user.valid?
	end 
	
	test "password must obey minimum length" do
		@user.password = "1234567"
		assert_not @user.valid?
	end
  
	test "authenticated? should return false for a user with no digest" do
		assert_not @user.authenticated?('')
	end
  
end
