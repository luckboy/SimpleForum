class AddCreatedLastPostAtToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :created_last_post_at, :datetime
  end
end
