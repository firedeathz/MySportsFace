class User < ActiveRecord::Base
  acts_as_voter
  
  has_many :favorites
  has_many :favorite_organizations, through: :favorites, source: :favorited, source_type: 'Organization'

  has_many :events
  has_many :active_participations, class_name:  "Participation",
                                   foreign_key: "user_id",
                                   dependent:   :destroy
  has_many :participations, through: :active_participations, source: :event
  
  
  has_many :comments
  has_many :event_comments
  has_many :microposts, dependent: :destroy
  
  
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy								  
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :identities
  
  attr_accessor :remember_token
  before_save { email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
				format: { with: VALID_EMAIL_REGEX },
				uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 8 }

  def User.digest(string)
	cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
													  BCrypt::Engine.cost
	BCrypt::Password.create(string, cost: cost)
  end
  
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  def forget
    update_attribute(:remember_digest, nil)
  end

  def authenticated?(remember_token)
	return false if remember_digest.nil?  
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end  
  
  def feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE  follower_id = :user_id"
    Micropost.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
  end
  
  def participate(event, creator_val, admin_val)
	active_participations.create(event_id: event.id, admin: admin_val, creator: creator_val)
  end
  
  def remove_participation(event)
	active_participations.find_by(event_id: event.id).destroy
  end
  
  def participating?(event)
	participations.include?(event)
  end
  
  def event_admin?(event)
	participation = active_participations.find_by(event_id: event.id)
	if(!participation.nil?)
		participation.admin?
	else 
		false
	end
  end
  
  def event_creator?(event)
	participation = active_participations.find_by(event_id: event.id)
	if(!participation.nil?)
		participation.creator?
	else 
		false
	end
  end
  
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end
  
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end  
  
  def self.find_for_oauth(auth, signed_in_resource = nil)
	identity = Identity.find_for_oauth(auth)
	
	user = signed_in_resource ? signed_in_resource : identity.user
	
	if user.nil?
		email = auth.info.email
		user = User.where(:email => email).first if email
		
		if user.nil?
			user = User.new(name: auth.info.name, email: auth.info.email, password: "********")
			user.save!
		end
	end
	
	if identity.user != user
		identity.user = user
		identity.save!
	end
	user
  end
  
  def self.search(query)
	where("name like ?", "%#{query}%")
  end
end
