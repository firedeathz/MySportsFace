class Article < ActiveRecord::Base
	acts_as_voteable
	
	belongs_to :organization
	has_many :comments
	accepts_nested_attributes_for :comments
	
	validates :atom_id, uniqueness: {scope: :organization_id}
	
	default_scope {
		order('created_at DESC')
	}
	
	def self.search(query)
		where("title like ?", "%#{query}%")
	end
end
