class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :content
      t.references :commenter, foreign_key: false
      t.references :post, foreign_key: true
    end
  end
end
