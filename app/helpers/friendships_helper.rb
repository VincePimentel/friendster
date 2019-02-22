module FriendshipsHelper

  def status_pending?(user)
    current_user.friendship(user)&.status == 0
  end

  def friends?(user)
    current_user.friends.find_by(id: user)
  end

  def request_notification
    link_to users_path, class: "nav-link" do
      icon("fas", "users") + " " + (tag.span(current_user.received_requests.size, class: "badge badge-danger") if current_user.received_requests.size > 0)
    end
  end

  def button(object, action)
    case action
    when "add friend"
      add_button(object, action)
    when "accept"
      add_button(object, action) + " " + reject_button
    when "cancel"
      cancel_button(object, action)
    when "edit"
      edit_button(object)
    else
      relationship_badge(object, action) + " " + edit_link(object)
    end
  end

  def add_button(user, action)
    if current_user != user
      link_to friendships_path(friend_id: user),
        method: :post,
        role: "button",
        class: "btn btn-primary btn-sm" do

        icon_label("plus", action)
      end
    end
  end

  def cancel_button(user, action)
    if current_user != user
      link_to friendship_path(current_user.friendship(user)),
        method: :delete,
        data: { confirm: "Are you sure?" },
        role: "button",
        class: "btn btn-primary btn-sm" do

        icon_label("minus", action)
      end
    end
  end

  def reject_button
    link_to friendship_path(current_user.referenced_friendship),
      method: :delete,
      data: { confirm: "Are you sure?" },
      role: "button",
      class: "btn btn-primary btn-sm" do

      icon_label("minus", "reject")
    end
  end

  def edit_button(user)
    if current_user != user
      link_to edit_friendship_path(current_user.friendship(user)),
        role: "button",
        class: "btn btn-light btn-sm float-right" do

        icon_label("edit", "edit")
      end
    end
  end

  def relationship_badge(friend, user)
    tag.small user.friendship(friend).relationship, class: "badge badge-pill badge-primary"
  end

  def edit_link(user)
    if current_user != user
      link_to edit_friendship_path(current_user.friendship(user)), class: "text-decoration-none" do

        icon_label("edit", "edit")
      end
    end
  end

  def icon_label(icon, action)
    tag.small(icon("fas", "user-#{icon}") + " #{action.titleize}")
  end

  def timeline_friends(user, friend)
    tag.div class: "col-4 px-1 py-0 text-center" do
      link_to user_path(friend), class: "text-decoration-none" do
        image_tag(friend.avatar, id: "friends-avatar", class: "img-fluid") + tag.p(tag.small(friend.first_name), id: "friends-name")
      end
    end
  end

end
