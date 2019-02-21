class User < ApplicationRecord
  include Gravtastic
  gravtastic

  has_secure_password

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  has_many :referenced_friendships, class_name: "Friendship", foreign_key: "friend_id"
  has_many :referenced_friends, through: :referenced_friendships, source: :user

  has_many :posts, dependent: :destroy
  has_many :comments, through: :posts, dependent: :destroy

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def users_by_friendship_status(status)
    User.where(id: self.friendships.where(status: status).pluck(:friend_id))
  end

  def available_friends
    # Get users that are not user's friends and have not sent a friend request
    ids = self.friends.pluck(:id) + (self.friendships.where(status: 0).pluck(:friend_id)) + (self.referenced_friendships.where(status: 0).pluck(:user_id)) << self.id

    User.where.not(id: ids)
  end

  def pending_requests
    # Outgoing friend requests to other users
    User.where(id: self.friendships.where(status: 0).pluck(:friend_id))
  end

  def friend_requests
    # Incoming friend requests from other users
    User.where(id: self.referenced_friendships.where(status: 0).pluck(:user_id))
  end

  def find_friendship(user)
    self.friendships.find_by(friend_id: user, status: 0)
  end
end
