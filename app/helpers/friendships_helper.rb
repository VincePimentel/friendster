module FriendshipsHelper

  def request_notification
    link_to users_path, class: "nav-link" do
      icon("fas", "users") + " " + (tag.span(current_user.friend_requests.size, class: "badge badge-danger") if current_user.friend_requests.size > 0)
    end
  end

  def button(user, type)
    case type
    when "add", "accept"
      plus_button(user, type)
    when "cancel"
      minus_button(user)
    end
  end

  def plus_button(user, type)
    link_to friendships_path(friend_id: user),
      method: :post,
      role: "button",
      class: "btn btn-primary btn-sm" do

      case type
      when "add"
        icon_label("plus", "add friend")
      when "accept"
        icon_label("plus", "accept")
      end
    end
  end

  def minus_button(user)
    if current_user.find_friendship(user)
      link_to friendship_path(current_user.find_friendship(user)),
        method: :delete,
        data: { confirm: "Are you sure?" },
        role: "button",
        class: "btn btn-primary btn-sm" do

        icon_label("minus", "cancel")
      end
    end
  end

  def icon_label(icon, label)
    tag.small(icon("fas", "user-#{icon}") + " #{label.titleize}")
  end

end
