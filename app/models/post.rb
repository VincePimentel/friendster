class Post < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :commenters, through: :comments, class_name: "User", foreign_key: "commenter_id"
  # has_many :hashtags
end
