require 'digest/md5'

class Feed < ActiveRecord::Base
	belongs_to :organization
	has_many :entries, dependent: :destroy
	
	validates :url, uniqueness: true
	
	def secret
		Digest::MD5.hexdigest(created_at.to_s)
	end
	
	def notified params
		update_attributes(:status => params["status"]["http"])
		params['items'].each do |i|
			entries.create(:atom_id => i["id"], :title => i["title"], :url => i["id"], :description => i["summary"], :content => i["content"])
			if i["permalinkUrl"].nil?
				organization.articles.create(:atom_id => i["id"], :author => organization.name, :title => i["title"], :url => i["id"], :description => i["summary"], :content => i["content"])
			else
				organization.articles.create(:atom_id => i["id"], :author => organization.name, :title => i["title"], :url => i["permalinkUrl"], :description => i["summary"], :content => i["content"])
			end
		end
	end
end
