module FormHelper
	def setup_organization(org)
		org.feed ||= Feed.new
		org
	end
end
