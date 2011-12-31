class AddPerPageFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :posts_per_page, :integer, :default => 15
    add_column :users, :topics_per_page, :integer, :default => 30
    add_column :users, :users_per_page, :integer, :default => 30
  end
end
