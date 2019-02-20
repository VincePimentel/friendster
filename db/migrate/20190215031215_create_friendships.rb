class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.string :relationship, default: "Friends"
      t.integer :status, default: 0
      t.references :user, foreign_key: true
      t.references :friend, foreign_key: false

      t.timestamps
    end
  end
end
