class Post < ApplicationRecord
  include PublicActivity::Common

  belongs_to :user
  has_many :comments, dependent: :destroy
end
