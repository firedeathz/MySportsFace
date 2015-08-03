class Comment < ActiveRecord::Base
  belongs_to :article
  belongs_to :user
  acts_as_voteable
  
  validates :body, presence: true
end
