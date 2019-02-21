module FriendshipsHelper

  def friend_request_count
    current_user.friend_requests.size
  end
end
