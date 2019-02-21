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

  # ADD VALIDATIONS FOR
  # => username
  # => email
  # => password

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def available_friends
    # Get user IDs of users current user is friends with,
    # has sent a friend request to,
    # has received a friend request from,
    # and self.

    ids = current_friend_ids + sent_request_ids + received_request_ids << self.id

    User.where.not(id: ids)
  end

  def current_friends
    User.where(id: current_friend_ids)
  end

  def sent_requests
    # Outgoing friend requests to other users
    User.where(id: sent_request_ids)
  end

  def received_requests
    # Incoming friend requests from other users
    User.where(id: received_request_ids)
  end

  def friendship(user)
    # self.friendships.find_by(friend_id: user, status: 0)
    self.friendships.find_by(friend_id: user)
  end

  def referenced_friendship
    # self.referenced_friendships.find_by(friend_id: self, status: 0)
    self.referenced_friendships.find_by(friend_id: self)
  end

  private

    def current_friend_ids
      self.friendships.where(status: 1).pluck(:friend_id)
    end

    def sent_request_ids
      self.friendships.where(status: 0).pluck(:friend_id)
    end

    def received_request_ids
      self.referenced_friendships.where(status: 0).pluck(:user_id)
    end
end
