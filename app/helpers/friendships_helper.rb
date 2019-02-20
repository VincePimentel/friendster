module FriendshipsHelper

  def friend_request_count
    current_user.referenced_friendships.where(status: 0).size
  end
end
