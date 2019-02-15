class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.text :bio
      t.string :location
      t.string :website
      t.string :instagram
      t.string :twitter
      t.string :gender

      t.timestamps
    end
  end
end
