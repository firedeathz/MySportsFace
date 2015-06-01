class Video < ActiveRecord::Base
	belongs_to :event
	
	LINK_FORMAT = /\A.*((youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)|(vimeo.com\/|channels\/|.*\/))([^#\&\?]*).*/i
	YT_LINK_FORMAT = /\A.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/i
	VIMEO_LINK_FORMAT = /\A.*(vimeo.com\/|channels\/|.*\/)([^#\&\?]*).*/i
	validates :link, presence: true, format: LINK_FORMAT
	
	before_create -> do
		if link.match(YT_LINK_FORMAT)
			id = link.match(YT_LINK_FORMAT)
			self.link = "https://youtube.com/embed/" + id[2] if id && id[2]
		elsif link.match(VIMEO_LINK_FORMAT)
			id = link.match(VIMEO_LINK_FORMAT)
			self.link = "https://player.vimeo.com/video/" + id[2] if id && id[2]
		end
	end
end
