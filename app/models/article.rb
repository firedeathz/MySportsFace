class Article < ActiveRecord::Base
  belongs_to :organization
  has_many :comments
  accepts_nested_attributes_for :comments
end
