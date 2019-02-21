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
  * Add relationship
  * Show - fix avatar cropping
  * DONE - Add header (str) attribute
  * DONE - Add avatar (str) attribute
  * DONE - Add username (str) attribute

Tags (or Hashtags?)
  * Add tag model for posts

Post
  * Add dropdown for tags
  * Add edit feature
  * Add location (bool) attribute (where user posted the post)
    - Display Vince -> Alice

Comment
  * Add comment box to:
    - users show
    - DONE - home index
  * DONE - Set up associations (belongs_to User and Post)

Like
  * Set up

Registration
  * Add @ to username field

Navigation
  * Change active link depending on current page
  * Add badge for friend request count

Friendship
  * DONE - Set up associations
  * DONE - Add relationship (str) attribute

<% if current_user.friendships.find_by(friend_id: user, status: 0) %>
      <%= link_to friendship_path(current_user.friendships.find_by(friend_id: user, status: 0)),
        method: :delete,
        role: "button",
        data: { confirm: "Are you sure?" },
        class: "btn btn-primary btn-sm" do %>
        <%= tag.small(icon("fas", "user-minus") + " Cancel") %>

      <% end %>
    <% else %>
      <%= link_to friendships_path(friend_id: user),
        method: :post,
        role: "button",
        class: "btn btn-primary btn-sm" do %>
        <% if user.friendships.find_by(friend_id: current_user, status: 0) %>
          <%= tag.small(icon("fas", "user-plus") + " Accept") %>
        <% else %>
          <%= tag.small(icon("fas", "user-plus") + " Add Friend") %>
        <% end %>
      <% end %>
    <% end %>
