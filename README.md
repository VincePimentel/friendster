# README

TO-DO

Home
  * Build index
  * Display only:
    - posts
    - comments

User
  * Add edit view
  * Add settings?
  * DONE - Add relationship
  * Fix avatar cropping and border
  * DONE - Add header (str) attribute
  * DONE - Add avatar (str) attribute
  * DONE - Add username (str) attribute

Tags (or Hashtags?)
  * REMOVED - Add tag model for posts

Post
  * REMOVED - Add dropdown for tags
  * DONE - Add edit feature
  * Add location (bool) attribute (where user posted the post)
    - Display Vince -> Alice

Comment
  * DONE - Add comment box to:
    - DONE - users show
    - DONE - home index
  * DONE - Set up associations (belongs_to User and Post)

Like
  * REMOVED - Set up

Registration
  * Add @ to username field

Navigation
  * Change active link depending on current page
  * DONE - Add badge for friend request count

Friendship
  * DONE - Set up associations
  * DONE - Add relationship (str) attribute

  <% if @user == current_user && @requests.size > 0 %>
    <h5>Friend Requests <%= "(#{@requests.size})" if @requests.size > 0 %></h5>

    <ul>
      <% @requests.each do |request| %>
        <li>
          <%= link_to request.user.full_name, user_path(request.user), target: "_blank" %>
          (<%= link_to "Accept", friendships_path(friend_id: request.user), method: :post %>)
        </li>
      <% end %>
    </ul>

    <hr>
  <% end %>

  <h5>Friends <%= "(#{@user.friendships.size})" if @user.friendships.size > 0 %></h5>

    <%= render partial: "friendships/friends",
      locals: {
        friendships: @user.friendships
      } %>
