class Picture < ActiveRecord::Base
	belongs_to :event
	mount_uploader :url, PictureUploader
	validate :picture_is_present
	validate :picture_size
	
	private
  
		def picture_is_present
			if url.blank?
				errors.add("No photo", "was selected.")
			end
		end
  
		def picture_size
			if url.size > 3.megabytes
				errors.add("Photo", "should be less than 3MB.")
			end
		end
end
