class Post < ApplicationRecord
  include PublicActivity::Common

  belongs_to :user
end
