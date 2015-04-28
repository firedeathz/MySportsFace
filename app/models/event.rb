class Event < ActiveRecord::Base
  has_many :pictures
  belongs_to :user
  
  has_many :passive_participations, class_name:  "Participation",
                                    foreign_key: "event_id",
                                    dependent:   :destroy
  has_many :participants, through: :passive_participations, source: :user
  
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :name, presence: true, length: { minimum: 8 }
  
  def add_participant(user, admin_val, creator_val)
	passive_participations.create(user_id: user.id, admin: admin_val, creator: creator_val)
  end
  
  def remove_participant(user)
	passive_participations.find_by(user_id: user.id).destroy
  end
  
  def has_participant?(user)
	participants.include?(user)
  end

end
