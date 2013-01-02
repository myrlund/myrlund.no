class AddProfileFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_index :users, :name
    add_column :users, :short_bio, :string
    add_column :users, :bio, :text
    add_column :users, :twitter, :string
    add_column :users, :github, :string
    add_column :users, :website, :string
  end
end
