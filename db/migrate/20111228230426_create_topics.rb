class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :subject
      t.references :author
      t.references :forum

      t.timestamps
    end
    add_index :topics, :author_id
    add_index :topics, :forum_id
  end
end
