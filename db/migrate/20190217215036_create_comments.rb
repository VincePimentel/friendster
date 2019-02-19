class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :content
      t.references :post, foreign_key: true
      t.references :commenter, foreign_key: false
    end
  end
end
