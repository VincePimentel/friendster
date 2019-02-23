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

  validates :first_name, :last_name, :username, :email, presence: true
  validates :password, length: { minimum: 6 }, on: :create
  validates :password_confirmation, presence: true, on: :create

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def available_friends
    # Get user IDs of all users:
    # 1) current user is friends with
    # 2) current user has sent a friend request to
    # 3) current user has received a friend request from
    # 4) and self
    ids = current_friend_ids + sent_request_ids + received_request_ids << self.id

    # Retrieve all users that are not included in the array of user IDs
    User.where.not(id: ids)
  end

  # Retrieve all users current user is
  # confirmed friends with (status: 1)
  def current_friends
    User.where(id: current_friend_ids)
  end

  # Retrieve outgoing friend requests to other users
  def sent_requests
    User.where(id: sent_request_ids)
  end

  # Retrieve incoming friend requests from other users
  def received_requests
    User.where(id: received_request_ids)
  end

  # Retrieve friendship from friend
  def friendship(friend)
    self.friendships.find_by(friend_id: friend)
  end

  # Retrieve friendship from friend's friendship table
  def referenced_friendship
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
