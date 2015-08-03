class EventComment < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  acts_as_voteable
  
  validates :body, presence: true
end
