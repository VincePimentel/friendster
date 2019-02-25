class Post < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :users, through: :comments
  # has_many :commenters, through: :comments

  validates :content, presence: true

  def self.by_friends(user)
    # Get all IDs of user's friends and self
    ids = user.friends.pluck(:id) << user.id

    where(user_id: ids, audience: 1).order("created_at DESC")
  end

  def self.on_timeline(user)
    where(recipient_id: user).order("created_at DESC")
  end
end
