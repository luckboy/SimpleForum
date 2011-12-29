class Forum < ActiveRecord::Base
  has_many :topics

  def posts
    Post.joins(:topic).where(:topics => { :forum_id => self })
  end
end
