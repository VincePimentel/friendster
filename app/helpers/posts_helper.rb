module PostsHelper

  def post_header(post)
    post_header_info(post) + post_header_controls(post)
  end

  def post_header_info(post)
    if post.recipient_id == post.user.id
      link_to(post.user.full_name, user_path(post.user))
    else
      link_to(post.user.full_name, user_path(post.user)) + " " + icon("fas", "caret-right") + " " + link_to(User.find(post.recipient_id).full_name, user_path(post.recipient_id))
    end
  end

  def post_header_controls(post)
    if current_user == post.user
      tag.span class: "float-right" do
        link_to(icon("fas", "edit"),
          edit_user_post_path(post.user.id, post),
          class: "text-dark") +
        " " +
        link_to(icon("fas", "trash"),
          user_post_path(post.user.id, post),
          method: :delete,
          data: { confirm: "Are you sure?" },
          class: "text-dark")
      end
    end
  end

  def post_body(post)
    if post.content.empty?
      post_body_image(post)
    else
      post_body_content(post) + post_body_image(post)
    end
  end

  def post_body_content(post)
    tag.div post.content, class: "col py-3"
  end

  def post_body_image(post)
    if !post.link.empty?
      link_to post.link, target: "_blank" do
        image_tag post.link, class: "img-fluid"
      end
    end
  end

  def post_datetime(post)
    post.created_at.localtime.strftime("%A, %d %b %Y %l:%M %p")
  end

end
