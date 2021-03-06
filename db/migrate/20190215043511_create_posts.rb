class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.text :content
      t.string :link
      t.integer :recipient_id
      t.integer :audience, default: 1
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
