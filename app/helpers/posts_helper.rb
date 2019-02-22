module PostsHelper

  def post_header(post)
    <% if post.recipient_id == post.user.id %>
            <%= link_to post.user.full_name, user_path(post.user) %>
          <% else %>
            <%= link_to post.user.full_name, user_path(post.user) %> <%= icon("fas", "caret-right") %> <%= link_to User.find(post.recipient_id).full_name, user_path(post.recipient_id) %> <!-- helperize me -->
          <% end %>

          <% if current_user == post.user %>
            <span class="float-right">
              <%= link_to icon("fas", "edit"),
                edit_user_post_path(post.user.id, post) %>
              <%= link_to icon("fas", "trash"),
                user_post_path(post.user.id, post),
                method: :delete,
                data: { confirm: "Are you sure?" } %>
            </span>
          <% end %>
  end

  def post_datetime(post)
    post.created_at.localtime.strftime("%A, %d %b %Y %l:%M %p")
  end

end
