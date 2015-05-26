class ScheduleEntry < ActiveRecord::Base
  belongs_to :event
  validates :description, 	presence: true
  validates :timeloc,		presence: true
  
end
