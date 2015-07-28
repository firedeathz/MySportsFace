class Event < ActiveRecord::Base
  has_many :pictures, :dependent => :destroy
  has_many :videos, :dependent => :destroy
  has_many :schedule_entries, :dependent => :destroy
  has_many :event_comments, :dependent => :destroy
  belongs_to :user
  
  acts_as_voteable
  
  has_many :passive_participations, class_name:  "Participation",
                                    foreign_key: "event_id",
                                    dependent:   :destroy
  has_many :participants, through: :passive_participations, source: :user
  
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :name, presence: true, length: { minimum: 8 }
  validates :location, presence: true
  validates :time, presence: true
  validates :date, presence: true
  
  def add_participant(user, admin_val, creator_val)
	passive_participations.create(user_id: user.id, admin: admin_val, creator: creator_val)
  end
  
  def remove_participant(user)
	passive_participations.find_by(user_id: user.id).destroy
  end
  
  def has_participant?(user)
	participants.include?(user)
  end
  
  def admins
    admin_ids = "SELECT user_id FROM participations
                 WHERE  event_id = :event_id AND admin = :val"
    User.where("id IN (#{admin_ids})", event_id: id, val: true)
  end
  
  def creator
	creator_id = "SELECT user_id FROM participations
				  WHERE  event_id = :event_id AND creator = :val"
	User.where("id IN (#{creator_id})", event_id: id, val: true)
  end
  
  def user_participants
	participant_ids = "SELECT user_id FROM participations
					   WHERE  event_id = :event_id AND admin = :admin AND creator = :creator"
	User.where("id IN (#{participant_ids})", event_id: id, admin: false, creator: false) 
  end
  
  def self.search(query)
	where("name like ?", "%#{query}%")
  end

end
