class Article < ActiveRecord::Base
	belongs_to :organization
	has_many :comments
	accepts_nested_attributes_for :comments
	
	validates :atom_id, uniqueness: {scope: :organization_id}
	
	default_scope {
		order('created_at DESC')
	}
end
