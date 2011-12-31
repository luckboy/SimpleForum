class Post < ActiveRecord::Base
  belongs_to :author, :class_name => "User", :foreign_key => "author_id"
  belongs_to :topic
  
  def by_admin?
    author.admin? unless author.nil?
  end
  
  def by_mod?
    author.mod? unless author.nil?
  end
  
  after_create do |post|
    post.topic.update_attribute :created_last_post_at, post.created_at
  end
end
