class User < ApplicationRecord
  has_secure_password

  has_many :friendships
  has_many :friends, through: :friendships

  has_many :referenced_friendships, class_name: "Friendships", foreign_key: "friend_id"
  has_many :referenced_friends, through: :referenced_friendships, source: :user

  has_many :posts

  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end
