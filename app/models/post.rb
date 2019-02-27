class Post < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy
  # has_many :users, through: :comments
  has_many :commenters, through: :comments, source: :user

  validate :content_can_be_blank_if_image_exists
  validate :link_must_be_valid_image

  # SCOPE
  def self.trending
    order("comments_count DESC").first
  end

  def content_can_be_blank_if_image_exists
    if content.empty? && link.empty?
      errors.add(:content, "cannot be blank")
    end
  end

  def link_must_be_valid_image
    if !link.empty? && !valid_url?(link)
      errors.add(:link, "must be a valid image")
    end
  end

  def valid_url?(link)
    # Returns a boolean if URL ends with a (.) followed by an image extension
    !!(link =~ /\.(jpg|jpeg|gif|png|apng|svg|bmp|ico)\z/)
  end

  def self.by_friends(user)
    # Get all IDs of user's friends and self
    ids = user.friends.pluck(:id) << user.id

    where(user_id: ids, audience: 1).order("created_at DESC")
  end

  def self.on_timeline(user)
    where(recipient_id: user).order("created_at DESC")
  end

  def datetime
    created_at.localtime.strftime("%A, %d %b %Y %l:%M %p")
  end
end
