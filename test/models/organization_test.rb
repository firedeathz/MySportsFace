require 'test_helper'

class OrganizationTest < ActiveSupport::TestCase

	def setup
		@organization = organizations(:exampleorg)
	end

	test "should be valid" do
		assert @organization.valid?
	end
	
end
