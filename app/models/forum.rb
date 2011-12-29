class Forum < ActiveRecord::Base
  has_many :topics, :order => "created_at DESC"

  def posts
    Post.joins(:topic).where(:topics => { :forum_id => self })
  end
end
