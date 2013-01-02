class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :url
      t.integer :author_id
      t.references :category
      t.text :content

      t.timestamps
    end
    add_index :posts, :category_id
  end
end
