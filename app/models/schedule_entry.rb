class ScheduleEntry < ActiveRecord::Base
  belongs_to :event
  validates :description, 	presence: true
  validates :time, 			presence: true
  
end
