class Participation < ActiveRecord::Base
	belongs_to :event, class_name: "Event"
	belongs_to :user, class_name: "User"
	validates :event_id, presence: true
	validates :user_id, presence: true
end
