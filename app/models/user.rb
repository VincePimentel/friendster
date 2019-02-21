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

  def users_by_friendship_status(status)
    User.where(id: self.friendships.where(status: status).pluck(:friend_id))
  end

  def available_friends
    # Get user IDs of users current user is friends with,
    # has sent a friend request to,
    # has received a friend request from,
    # and self.

    ids = current_friends + sent_requests + received_requests << self.id

    User.where.not(id: ids)
  end

  def pending_requests
    # Outgoing friend requests to other users
    User.where(id: sent_requests)
  end

  def friend_requests
    # Incoming friend requests from other users
    User.where(id: received_requests)
  end

  def find_friendship(user)
    self.friendships.find_by(friend_id: user, status: 0)
  end

  private

    def sent_requests
      self.friendships.where(status: 0).pluck(:friend_id)
    end

    def received_requests
      self.referenced_friendships.where(status: 0).pluck(:user_id)
    end

    def current_friends
      self.friends.pluck(:id)
    end
end
