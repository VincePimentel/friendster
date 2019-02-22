module UsersHelper

  def edit_profile_button
    link_to edit_user_path(current_user),
      role: "button",
      class: "btn btn-light btn-sm float-right" do

      tag.small(icon("fas", "user-edit") + " Edit Profile")
    end
  end
end
