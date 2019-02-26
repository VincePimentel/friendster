class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :uid
      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :email
      t.string :password_digest
      t.text :bio
      t.string :location
      t.string :website
      t.string :instagram
      t.string :twitter
      t.string :gender
      t.string :cover
      t.string :avatar

      t.timestamps
    end
  end
end
