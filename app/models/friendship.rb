class Friendship < ApplicationRecord
  belongs_to :user, counter_cache: :friends_count
  belongs_to :friend, class_name: "User"

  validates :relationship, presence: true
end
