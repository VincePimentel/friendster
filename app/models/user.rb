class User < ApplicationRecord
  include Gravtastic
  gravtastic

  has_secure_password

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  has_many :referenced_friendships, class_name: "Friendship", foreign_key: "friend_id"
  has_many :referenced_friends, through: :referenced_friendships, source: :user

  has_many :posts, dependent: :destroy

  has_many :comments, dependent: :destroy
  has_many :commented_posts, through: :comments, source: :post

  validates :first_name,
            :last_name,
            :username,
            :email,
            presence: true

  validates :password,
            length: { minimum: 6 },
            on: :create

  validates :password_confirmation,
            presence: true,
            on: :create

  def full_name
    "#{first_name} #{last_name}"
  end

  def default_avatar
    gravatar_url + "&d=robohash&size=175"
  end

  def available_friends
    # Get user IDs of all users:
    # 1) current user is friends with
    # 2) current user has sent a friend request to
    # 3) current user has received a friend request from
    # 4) and self
    ids = current_friends_ids + sent_requests_ids + received_requests_ids << id

    # Retrieve all users that are not included in the array of user IDs
    User.where.not(id: ids)
  end

  # Retrieve all users current user is
  # confirmed friends with (status: 1)
  def current_friends
    User.where(id: current_friends_ids)
  end

  # Retrieve outgoing friend requests to other users
  def sent_requests
    User.where(id: sent_requests_ids)
  end

  # Retrieve incoming friend requests from other users
  def received_requests
    User.where(id: received_requests_ids)
  end

  # Retrieve friendship from friend
  def friendship(friend)
    friendships.find_by(friend_id: friend)
  end

  # Retrieve friendship from friend's friendship table
  def referenced_friendship
    referenced_friendships.find_by(friend_id: id)
  end

  private

    def current_friends_ids
      friendships.where(status: 1).pluck(:friend_id)
    end

    def sent_requests_ids
      friendships.where(status: 0).pluck(:friend_id)
    end

    def received_requests_ids
      referenced_friendships.where(status: 0).pluck(:user_id)
    end
end
