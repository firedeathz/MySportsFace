class User < ActiveRecord::Base
	before_save { self.email = email.downcase }
	validates :name,  presence: true, length: { maximum: 20 }
	VALID_EMAIL_REGEX = /\A[\w\d.]+@([\w\d]+.)+[\w\d]+\z/i
	validates :email, presence: true, length: { maximum: 255 }
					, format: { with: VALID_EMAIL_REGEX }
					, uniqueness: { case_sensitive: false }
					
	has_secure_password
end
