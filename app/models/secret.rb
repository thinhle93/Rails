class Secret < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :content
  has_many :likes
  has_many :users, through: :likes
end
