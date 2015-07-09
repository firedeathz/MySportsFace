class Organization < ActiveRecord::Base
	has_many :articles
	has_one :feed
	accepts_nested_attributes_for :articles
	accepts_nested_attributes_for :feed
	
	def self.search(query)
		where("name like ?", "%#{query}%")
	end
end
