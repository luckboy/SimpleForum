class Forum < ActiveRecord::Base
  has_many :topics, :order => "created_last_post_at DESC", :dependent => :destroy
  
  validates :name, :presence => true, :uniqueness => true

  def posts
    Post.joins(:topic).where(:topics => { :forum_id => self })
  end
end
