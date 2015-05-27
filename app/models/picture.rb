class Picture < ActiveRecord::Base
	belongs_to :event
	mount_uploader :url, PictureUploader

end
