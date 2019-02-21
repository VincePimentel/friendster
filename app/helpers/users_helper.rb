module UsersHelper

  def plus_button(user, type)
    link_to friendships_path(friend_id: user),
          method: :post,
          role: "button",
          class: "btn btn-primary btn-sm" do

      case type
      when "add"
        generate_button("plus", "add friend")
      when "accept"
        generate_button("plus", "accept")
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

        generate_button("minus", "cancel")
      end
    end
  end

  def generate_button(icon, label)
    tag.small(icon("fas", "user-#{icon}") + " #{label.titleize}")
  end

  def button(user, type)
    case type
    when "add", "accept"
      plus_button(user, type)
    when "cancel"
      minus_button(user)
    end
  end
end
