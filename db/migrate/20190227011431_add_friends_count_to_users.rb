class AddFriendsCountToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :friends_count, :integer
  end
end
