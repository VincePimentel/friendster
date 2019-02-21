class Post < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :users, through: :comments

  def self.by_friends_of(user)
    ids = user.friends.pluck(:id) << user.id

    self.where(user_id: ids).where(audience: 1).order("created_at DESC")
  end
end
